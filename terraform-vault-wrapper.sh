#!/bin/sh

TF_ACTION="${1:-apply}"
SECRET_PATH="secret/data/cicd/apikeys/grafana"

set -e

# make sure to delete vars before leaving
trap clean_credentials ERR EXIT

clean_credentials() {
    echo "Cleaning vars..."
    unset TF_VAR_grafana_api_token
    unset TF_VAR_grafana_url
}

if [ -n "${VAULT_TOKEN}" ] && [ -n "${VAULT_ADDR}" ]; then
    SECRET=$(curl --connect-timeout 3 -s -H "X-Vault-Token: ${VAULT_TOKEN}" "${VAULT_ADDR}/v1/${SECRET_PATH}")
    export GRAFANA_AUTH=$(echo ${SECRET} | jq -re '.data.data.token')
    export GRAFANA_URL=$(echo ${SECRET} | jq -re '.data.data.url')

    if [ "${TF_ACTION}" = "plan" ]; then
        terraform -chdir=tf plan
    elif [ "${TF_ACTION}" = "apply" ]; then
        terraform -chdir=tf apply
    elif [ "${TF_ACTION}" = "destroy" ]; then
        terraform -chdir=tf destroy
    fi

else
    echo "could not communicate to vault"
    exit 1
fi
