#!/usr/bin/env bash
exec > /var/log/nightking/startup.output
exec 2>&1
set -xeuo pipefail

if [ ! -f /var/log/nightking/.startup-finished ]; then
  # Create TICK stack for monitoring
  /usr/local/sbin/create-tls.bash
  /usr/local/sbin/setup-influx.bash
  /usr/local/sbin/setup-telegraf.bash
  /usr/local/sbin/setup-grafana.bash
  touch /var/log/nightking/.startup-finished
fi

/usr/local/sbin/experiment.bash
