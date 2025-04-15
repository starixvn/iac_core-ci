#!/bin/bash
set -eo pipefail

APP=$1
ENV=${2:-dev}
ACTION=${3:-apply}

cd "applications/$APP"
terraform init -backend-config="../../environments/$ENV/backend.hcl" -reconfigure
terraform workspace select "$ENV" || terraform workspace new "$ENV"

case "$ACTION" in
  plan)
    terraform plan -var-file="../../environments/$ENV/${APP}.tfvars"
    ;;
  apply)
    terraform apply -auto-approve -var-file="../../environments/$ENV/${APP}.tfvars"
    ;;
  *)
    echo "Usage: $0 <app-name> <env> [plan|apply]"
    exit 1
    ;;
esac