#!/usr/bin/env bash
exec > /root/experiment.output
exec 2>&1
set -xeuo pipefail
log() { # Log script results to influx DB - after it is set up
  influx -ssl -host $(cat /root/public-hostname) -username telegraf -password $(cat /root/influx-telegraf-password) -database telegraf -execute "INSERT nightking ${1}=${2}"
}

# Get Input
test -f /root/user-data || curl http://169.254.169.254/latest/user-data > /root/user-data
## Sanitize EXPERIMENT input
trap 'log experiment 11' ERR
export XP="$(stoml /root/user-data EXPERIMENT)"
trap 'log experiment 10' ERR
test -d /etc/xp/"${XP}"
log experiment 0

# Set up tendermint seed node
trap 'log seed 10' ERR
log seed 1
sudo -u tendermint tendermint init
sudo -u tendermint tendermint show_node_id > /root/seed_node_id
sudo -u tendermint tendermint unsafe_reset_all
cp /etc/xp/"${XP}"/seed/* /home/tendermint/.tendermint/config/
chown -R tendermint.tendermint /home/tendermint/.tendermint
systemctl start tendermint
log seed 0
trap '' ERR

# Set up terraform
# Todo: find out how to get access to AWS
trap 'log terraform_build 12' ERR
cd /etc/xp/"${XP}"/terraform
trap 'log terraform_build 11' ERR
log terraform_build 2
terraform init
trap 'log terraform_build 10' ERR
log terraform_build 1
terraform apply --auto-approve
log terraform_build 0

# Run tm-load-test server
# Todo: stemplate /etc/xp/"${XP}"/load-test.toml -o /etc/xp/"${XP}"/load-test.toml --string masterip,slavesnum
trap 'log tm-load-test 2' ERR
log tm-load-test 1
# Todo: tm-load-test --config /etc/xp/"${XP}"/load-test.toml
log tm-load-test 0

# Break down terraform
trap 'log terraform_destroy 2' ERR
log terraform_destroy 1
terraform destroy --force
log terraform_destroy 0
