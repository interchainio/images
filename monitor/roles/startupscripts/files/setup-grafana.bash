#!/usr/bin/env bash

set -xeuo pipefail

test -f /root/.grafana-setup-finished && exit

# Enable gzip compression
sed -i 's/^\(\s\|;\|#\)*enable_gzip\s*=.*$/enable_gzip = true/' /etc/grafana/grafana.ini

cat << EOF > /etc/grafana/provisioning/datasources/influx.yaml
apiVersion: 1
datasources:
  - name: influx
    type: influxdb
    access: proxy
    url: "http://localhost:8086"
    user: ${INFLUXDB_USERNAME}
    password: ${INFLUXDB_PASSWORD}
    database: ${INFLUXDB_DATABASE}
    isDefault: true
    editable: false
    jsonData:
      httpMode: GET
EOF
chmod 440 /etc/grafana/provisioning/datasources/influx.yaml
chgrp grafana /etc/grafana/provisioning/datasources/influx.yaml

systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server
sleep 3

gomplate -f /root/nginx-grafana.conf > /etc/nginx/conf.d/grafana.conf
systemctl restart nginx

touch /root/.grafana-setup-finished
