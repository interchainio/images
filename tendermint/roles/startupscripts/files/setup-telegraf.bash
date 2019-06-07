#!/usr/bin/env bash
set -xeuo pipefail

# Always deploy the Telegraf configuration
gomplate -f /root/telegraf.conf > /etc/telegraf/telegraf.conf

systemctl enable telegraf
systemctl restart telegraf
