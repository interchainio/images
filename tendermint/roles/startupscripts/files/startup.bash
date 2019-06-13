#!/usr/bin/env bash
exec > /root/startup.output
exec 2>&1
set -xeuo pipefail

# Always get our public hostname
export PUBLIC_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
hostname ${PUBLIC_HOSTNAME}

# Always get the latest user data with our current configuration
curl http://169.254.169.254/latest/user-data > /root/user-data
# Export all user data-driven environment variables
set -a
source /root/user-data
set +a

# Always deploy the Telegraf configuration
gomplate -f /root/telegraf.conf > /etc/telegraf/telegraf.conf

# Enable and (re)start Telegraf
systemctl enable telegraf
systemctl restart telegraf

# Enable and start Tendermint
systemctl enable tendermint
systemctl start tendermint
