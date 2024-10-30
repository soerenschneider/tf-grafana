#!/usr/bin/env bash

set -e

ENV=$(basename "$(pwd)")
PASS_PATH="infra/selfhosted/terraform-state/tf-grafana-${ENV}"

SECRET="$(pass "${PASS_PATH}")"
STATE_PASSWORD=$(echo "${SECRET}" | grep ^STATE_PASSWORD= | awk -F= '{print $2}')

GRAFANA_USER=$(echo "${SECRET}" | grep ^GRAFANA_USER= | awk -F= '{print $2}')
GRAFANA_PASSWORD=$(echo "${SECRET}" | grep ^GRAFANA_PASSWORD= | awk -F= '{print $2}')

export GRAFANA_AUTH="${GRAFANA_USER}:${GRAFANA_PASSWORD}"

TF_ENCRYPTION=$(cat <<EOF
key_provider "pbkdf2" "mykey" {
  passphrase = "${STATE_PASSWORD}"
}
EOF
)
export TF_ENCRYPTION

terragrunt init
terragrunt apply
terragrunt output bucket_names
