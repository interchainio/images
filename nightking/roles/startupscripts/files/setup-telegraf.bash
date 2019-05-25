#!/usr/bin/env bash

set -xeuo pipefail

test -f /root/.telegraf-setup-finished && exit

# Disable example influxdb setup in main config
sed -i 's/^\(\s\|#\)*\[\[outputs\.influxdb\]\].*$/#[[outputs.influxdb]]/' /etc/telegraf/telegraf.conf

# Add real influx connection
cat << EOF > /etc/telegraf/telegraf.d/influx.conf
[[outputs.influxdb]]
  urls = ["https://$(cat /root/public-hostname):8086"]
  skip_database_creation = true
  username = "telegraf"
  password = "$(cat /root/influx-telegraf-password)"
EOF
chmod 0440 /etc/telegraf/telegraf.d/influx.conf
chgrp telegraf /etc/telegraf/telegraf.d/influx.conf

systemctl enable telegraf
systemctl restart telegraf

touch /root/.telegraf-setup-finished
