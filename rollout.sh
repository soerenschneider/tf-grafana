#!/usr/bin/env bash

set -e

ENV="${1:-prod}"

echo "Running tofu apply for env ${ENV}"

GRAFANA_SECRET_PATH="infra/selfhosted/grafana-${ENV}"
TF_SECRET_PATH="infra/selfhosted/terraform-state/tf-grafana-${ENV}"

echo "Reading grafana credentials..."
OUTPUT=$(pass "${GRAFANA_SECRET_PATH}")
GRAFANA_USERNAME=$(echo "${OUTPUT}" | grep ^GRAFANA_USERNAME= | cut -d'=' -f2)
GRAFANA_PASSWORD=$(echo "${OUTPUT}" | grep ^GRAFANA_PASSWORD= | cut -d'=' -f2)

GRAFANA_AUTH="${GRAFANA_USERNAME}:${GRAFANA_PASSWORD}"
export GRAFANA_AUTH

echo "Reading opentofu state encryption key..."
OUTPUT=$(pass "${TF_SECRET_PATH}")
_TF_KEY=$(echo "${OUTPUT}" | head -n1)
export _TF_KEY

TF_ENCRYPTION=$(cat <<EOF
key_provider "pbkdf2" "mykey" {
  passphrase = "${_TF_KEY}"
}
EOF
)
export TF_ENCRYPTION

terragrunt --terragrunt-working-dir="envs/${ENV}" apply
