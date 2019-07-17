#!/usr/bin/env bash
exec > /var/log/nightking/experiment-$(date +%Y%m%d-%H%M%S).output
exec 2>&1
set -euo pipefail
source /usr/local/sbin/library.bash

## Sanitize EXPERIMENT input
trap 'log experiment 10' ERR
if [ "${EXPERIMENTS}" == "" ]; then
  EXPERIMENTS=$(ls /etc/experiments)
else
  CLEANED_EXPERIMENTS=""
  for XP in ${EXPERIMENTS}
  do
    # Todo: Create some warning messages is there's an invalid experiment in the list
    test -d /etc/experiments/"${XP}" || continue
    CLEANED_EXPERIMENTS="${CLEANED_EXPERIMENTS} ${XP}"
  done
  EXPERIMENTS="${CLEANED_EXPERIMENTS# }"
fi
log experiment 0

for XP in ${EXPERIMENTS}
do

    # Set up tendermint seed node
    trap 'log seed 10' ERR
    log seed 1
    sudo -u tendermint tendermint init
    sudo -u tendermint tendermint unsafe_reset_all
    cp /etc/experiments/"${XP}"/seed/* /home/tendermint/.tendermint/config/
    chown -R tendermint.tendermint /home/tendermint/.tendermint
    sudo -u tendermint tendermint show_node_id > /var/log/nightking/seed_node_id
    systemctl start tendermint
    log seed 0
    trap '' ERR

    # Set up terraform
    trap 'log terraform_build 12' ERR
    if [ -f /etc/experiments/"${XP}"/config.toml ]; then
      stemplate /usr/share/terraform-templates -f /etc/experiments/"${XP}"/config.toml -o /root/terraform-"${XP}" --all
      if [ -d /etc/experiments/"${XP}"/terraform ]; then
        stemplate /etc/experiments/"${XP}"/terraform -f /etc/experiments/"${XP}"/config.toml -o /root/terraform-"${XP}" --all
      fi
    else
      if [ -d /etc/experiments/"${XP}"/terraform ]; then
        cp -r /etc/experiments/"${XP}"/terraform /root/terraform-"${XP}"
      fi
    fi
    # Todo: Create some warning message if there is nothing to run in an experiment
    test -d /root/terraform-"${XP}" || continue
    cd /root/terraform-"${XP}"
    trap 'log terraform_build 11' ERR
    log terraform_build 2
    terraform init
    trap 'log terraform_build 10' ERR
    log terraform_build 1
    terraform apply --auto-approve
    log terraform_build 0

    # Set up and run tm-load-test master - wait until it finishes
    if [ -f /etc/experiments/"${XP}"/config.toml ]; then
      stemplate /etc/experiments/"${XP}"/load-test.toml.template -f /etc/experiments/"${XP}"/config.toml -o ${HOME}/load-test.toml --string PUBLIC_IP
    else
      stemplate /etc/experiments/"${XP}"/load-test.toml.template -o ${HOME}/load-test.toml --string PUBLIC_IP
    fi
    trap 'log tm-load-test 2' ERR
    log tm-load-test 1
    # Todo: Run as non-root user?
    tm-load-test --config ${HOME}/load-test.toml
    log tm-load-test 0

    # Break down terraform
    trap 'log terraform_destroy 2' ERR
    log terraform_destroy 1
    terraform destroy --force
    log terraform_destroy 0
done
