#!/bin/bash
set -eo pipefail

echo "Validating Terraform configuration in ${CI_PROJECT_DIR}"
terraform init
terraform validate
terraform plan -var-file=environments/${ENVIRONMENT}/${APP}.tfvars -out=tfplan