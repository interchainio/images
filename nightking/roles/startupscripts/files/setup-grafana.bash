#!/usr/bin/env bash

set -xeuo pipefail

test -f /root/.grafana-setup-finished && exit

# Enable HTTPS
sed -i 's/^\(\s\|;\|#\)*protocol\s*=.*$/protocol = https/' /etc/grafana/grafana.ini
# Set HTTPS port to 443
sed -i 's/^\(\s\|;\|#\)*http_port\s*=.*$/http_port = 443/' /etc/grafana/grafana.ini
# Enable gzip compression
sed -i 's/^\(\s\|;\|#\)*enable_gzip\s*=.*$/enable_gzip = true/' /etc/grafana/grafana.ini
# Set HTTPS public key
sed -i 's,^\(\s\|;\|#\)*cert_file\s*=.*$,cert_file = /etc/ssl/nightking.crt,' /etc/grafana/grafana.ini
# Set HTTPS private key
sed -i 's,^\(\s\|;\|#\)*cert_key\s*=.*$,cert_key = /etc/ssl/nightking.key,' /etc/grafana/grafana.ini

cat << EOF > /etc/grafana/provisioning/datasources/influx.yaml
apiVersion: 1
datasources:
  - name: influx
    type: influxdb
    access: proxy
    url: https://$(cat /root/public-hostname):8086
    user: telegraf
    password: $(cat /root/influx-telegraf-password)
    database: telegraf
    isDefault: true
    editable: false
    jsonData:
      httpMode: GET
EOF
chmod 440 /etc/grafana/provisioning/datasources/influx.yaml
chgrp grafana /etc/grafana/provisioning/datasources/influx.yaml

cat << EOF > /etc/grafana/provisioning/dashboards/nightking.yaml
apiVersion: 1
providers:
 - name: 'default'
   orgId: 1
   folder: ''
   type: file
   options:
     path: /var/lib/grafana/dashboards
EOF
chmod 440 /etc/grafana/provisioning/dashboards/nightking.yaml
chgrp grafana /etc/grafana/provisioning/dashboards/nightking.yaml

systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server
sleep 3

# Set Home page
set +e # Debug
NIGHTKING_ID="$(curl -s -H "Content-Type: application/json" "https://admin:admin@$(cat /root/public-hostname)/api/search?folderIds=0&query=Nightking%20status" | jq .[0].id)"
curl -X PUT -s -H "Content-Type: application/json" "https://admin:admin@$(cat /root/public-hostname)/api/user/preferences" -d "{\"homeDashboardId\":${NIGHTKING_ID}}"

log() { # Log script results to influx DB
  influx -ssl -host $(cat /root/public-hostname) -username telegraf -password $(cat /root/influx-telegraf-password) -database telegraf -execute "INSERT nightking ${1}=${2}"
}

touch /root/.grafana-setup-finished
log tick 0

# Get Input
set +e
test -f /root/user-data || curl http://169.254.169.254/latest/user-data > /root/user-data
## Sanitize PASSWORD input
LOG_PASSWORD=0
trap 'log password 12 ; exit' ERR
export PASSWORD="$(stoml /root/user-data PASSWORD)"
trap 'log password 11 ; exit' ERR
pw_data="{\"oldPassword\":\"admin\",\"newPassword\":\"${PASSWORD}\",\"confirmNew\":\"${PASSWORD}\"}"
PW_RESULT="$(curl -X PUT -H "Content-Type: application/json" -d "${pw_data}" "https://admin:admin@$(cat /root/public-hostname)/api/user/password")"

if [[ "${PW_RESULT}" == "{\"message\":\"New password is too short\"}" ]]; then
  log password 10
  exit
fi
log password 0
set -e
