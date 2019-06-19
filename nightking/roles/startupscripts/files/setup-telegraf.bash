#!/usr/bin/env bash

set -xeuo pipefail

test -f /var/log/nightking/.telegraf-setup-finished && exit

source /usr/local/sbin/library.bash

# Disable example influxdb setup in main config
sed -i 's/^\(\s\|#\)*\[\[outputs\.influxdb\]\].*$/#[[outputs.influxdb]]/' /etc/telegraf/telegraf.conf

# Add real influx connection
cat << EOF > /etc/telegraf/telegraf.d/influx.conf
[[outputs.influxdb]]
  urls = ["https://${PUBLIC_HOSTNAME}:8086"]
  skip_database_creation = true
  username = "telegraf"
  password = "${INFLUX_TELEGRAF_PASSWORD}"
EOF
chmod 0440 /etc/telegraf/telegraf.d/influx.conf
chgrp telegraf /etc/telegraf/telegraf.d/influx.conf

systemctl enable telegraf
systemctl restart telegraf

touch /var/log/nightking/.telegraf-setup-finished
