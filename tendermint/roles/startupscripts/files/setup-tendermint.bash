#!/usr/bin/env bash
set -xeuo pipefail

test -f /root/.tendermint-setup-finished && exit

# We assume Tendermint is being set up/configured for the first time on this
# machine, and that, if it is to be reconfigured, this will be performed through
# a different mechanism to this set of scripts.
sudo -u tendermint tendermint init
chown -R tendermint:tendermint /home/tendermint/.tendermint
systemctl enable tendermint
systemctl restart tendermint

touch /root/.tendermint-setup-finished
