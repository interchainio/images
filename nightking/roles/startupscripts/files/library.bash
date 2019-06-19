#!/usr/bin/env bash

##
# library.bash - a set of reusable bash functions. Usage: `source library.bash`
##


# Get public hostname
get-public-hostname() {
  test -f /var/log/nightking/public-hostname || curl -s http://169.254.169.254/latest/meta-data/public-hostname > /var/log/nightking/public-hostname
  cat /var/log/nightking/public-hostname
}

# Public hostname variable
export PUBLIC_HOSTNAME="$(get-public-hostname)"


# Get instance ID
get-instance-id() {
  test -f /var/log/nightking/instance-id || curl -s http://169.254.169.254/latest/meta-data/instance-id > /var/log/nightking/instance-id
  cat /var/log/nightking/instance-id
}

# Public hostname variable
export INSTANCE_ID="$(get-instance-id)"


# Get AWS region
get-aws-region() {
  test -f /var/log/nightking/aws-region || curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/[a-z]$//' > /var/log/nightking/aws-region
  cat /var/log/nightking/aws-region
}

# Public hostname variable
export AWS_REGION="$(get-aws-region)"


# Get InfluxDB password for Telegraf
get-influx-telegraf-password() {
  test -f /var/log/nightking/influx-telegraf-password || (openssl rand -base64 48 > /var/log/nightking/influx-telegraf-password && chmod 400 /var/log/nightking/influx-telegraf-password)
  cat /var/log/nightking/influx-telegraf-password
}

# InfluxDB Telegraf variable
export INFLUX_TELEGRAF_PASSWORD="$(get-influx-telegraf-password)"


# Get InfluxDB password for Admin
get-influx-admin-password() {
  test -f /var/log/nightking/influx-admin-password || (openssl rand -base64 48 > /var/log/nightking/influx-admin-password && chmod 400 /var/log/nightking/influx-admin-password)
  cat /var/log/nightking/influx-admin-password
}

# InfluxDB Admin variable
export INFLUX_ADMIN_PASSWORD="$(get-influx-admin-password)"


# Get password tag for website
get-password-tag() {
  test -f /var/log/nightking/password_tag || (aws ec2 describe-tags --region "${AWS_REGION}" --filters "Name=resource-id,Values=${INSTANCE_ID}" | jq -r '.Tags[] | select( .Key | ascii_downcase == "password" ).Value' > /var/log/nightking/password_tag && chmod 400 /var/log/nightking/password_tag && if [ -z "$(cat /var/log/nightking/password_tag)" ]; then echo "admin" > /var/log/nightking/password_tag; fi)
  cat /var/log/nightking/password_tag
}

export PASSWORD_TAG="$(get-password-tag)"


# Get experiments in a space-separated list - always up-to-date
get-experiments() {
  aws ec2 describe-tags --region "${AWS_REGION}" --filters "Name=resource-id,Values=${INSTANCE_ID}" | jq -r '.Tags[] | select( .Key | ascii_downcase == "experiments" ).Value' | tr ',' ' '
}

export EXPERIMENTS="$(get-experiments)"


# Log script results to influx DB
log() {
  influx -ssl -host "${PUBLIC_HOSTNAME}" -username telegraf -password "${INFLUX_TELEGRAF_PASSWORD}" -database telegraf -execute "INSERT nightking ${1}=${2}"
}
