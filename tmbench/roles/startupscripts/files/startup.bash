#!/usr/bin/env bash
exec > /root/startup.output
exec 2>&1
set -xeuo pipefail

# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------

# Always get our public hostname
export PUBLIC_HOSTNAME=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
hostname ${PUBLIC_HOSTNAME}

# By default we shut down automatically once done with testing
export AUTO_SHUTDOWN=1

# Always get the latest user data with our current configuration
curl http://169.254.169.254/latest/user-data > /root/user-data
# Export all user data-driven environment variables
set -a
source /root/user-data
set +a

# -----------------------------------------------------------------------------
# Telegraf configuration
# -----------------------------------------------------------------------------

# Always deploy the Telegraf configuration
gomplate -f /root/telegraf.conf > /etc/telegraf/telegraf.conf

systemctl enable telegraf
systemctl restart telegraf

# -----------------------------------------------------------------------------
# Execute the transactions once started up
# -----------------------------------------------------------------------------
tm-bench \
    -T ${TMBENCH_TIME} \
    -broadcast-tx-method ${TMBENCH_BROADCAST_TX_METHOD} \
    -c ${TMBENCH_CONNECTIONS} \
    -r ${TMBENCH_RATE} \
    -s ${TMBENCH_SIZE} \
    -v \
    ${TMBENCH_ENDPOINTS}

# -----------------------------------------------------------------------------
# Automatically shut down the instance
# -----------------------------------------------------------------------------

if [ "${AUTO_SHUTDOWN}" == 1 ]; then
    /usr/sbin/shutdown -t now
fi
