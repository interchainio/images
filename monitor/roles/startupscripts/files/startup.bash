#!/usr/bin/env bash
exec > /root/startup.output
exec 2>&1
set -xeuo pipefail

# Always get our public hostname
export PUBLIC_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
hostname ${PUBLIC_HOSTNAME}

curl http://169.254.169.254/latest/user-data > /root/user-data
set -a
source /root/user-data
set +a

if [ ! -f /root/.startup-finished ]; then
  /root/setup-influx.bash
  /root/setup-grafana.bash
  touch /root/.startup-finished
fi
