#!/usr/bin/env bash

set -xeuo pipefail

test -f /root/.influx-setup-finished && exit

openssl rand -base64 48 > /root/influx-telegraf-password
chmod 400 /root/influx-telegraf-password
openssl rand -base64 48 > /root/influx-admin-password
chmod 400 /root/influx-admin-password
systemctl start influxdb
sleep 5
influx -precision rfc3339 -execute "CREATE USER admin WITH PASSWORD '$(cat /root/influx-admin-password)' WITH ALL PRIVILEGES; CREATE DATABASE telegraf; CREATE USER telegraf WITH PASSWORD '$(cat /root/influx-telegraf-password)'; GRANT ALL ON telegraf TO telegraf"
systemctl stop influxdb

#Set up minimal config changes
# Enable HTTPS
sed -i 's/^\(\s\|#\)*https-enabled =.*$/  https-enabled = true/' /etc/influxdb/influxdb.conf
# Enable user authentication over HTTPS
sed -i 's/^\(\s\|#\)*auth-enabled =.*$/  auth-enabled = true/' /etc/influxdb/influxdb.conf
# Enforce min/max TLS version
sed -i 's/^\(\s\|#\)*\(min\|max\)-version/  \2-version/' /etc/influxdb/influxdb.conf

systemctl enable influxdb
systemctl start influxdb
sleep 5

touch /root/.influx-setup-finished
