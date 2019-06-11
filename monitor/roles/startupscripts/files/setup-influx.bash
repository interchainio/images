#!/usr/bin/env bash

set -xeuo pipefail

test -f /root/.influx-setup-finished && exit

openssl rand -base64 16 > /root/influxdb-admin-password
INFLUXDB_ADMIN_PASSWORD=${INFLUXDB_ADMIN_PASSWORD:-`cat /root/influxdb-admin-password`}

systemctl enable influxdb
systemctl start influxdb
sleep 5
influx -precision rfc3339 \
    -execute "CREATE USER admin WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
influx -precision rfc3339 \
    -execute "CREATE DATABASE ${INFLUXDB_DATABASE}; CREATE USER ${INFLUXDB_USERNAME} WITH PASSWORD '${INFLUXDB_PASSWORD}'; GRANT ALL ON ${INFLUXDB_DATABASE} TO ${INFLUXDB_USERNAME}"

touch /root/.influx-setup-finished
