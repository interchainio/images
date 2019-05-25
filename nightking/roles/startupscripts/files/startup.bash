#!/usr/bin/env bash
exec > /root/startup.output
exec 2>&1
set -xeuo pipefail

if [ ! -f /root/.startup-finished ]; then
  # Create TICK stack for monitoring
  /root/create-tls.bash
  /root/setup-influx.bash
  /root/setup-telegraf.bash
  /root/setup-grafana.bash
  touch /root/.startup-finished
fi

/root/experiment.bash
