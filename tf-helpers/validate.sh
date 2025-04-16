#!/bin/bash
set -eo pipefail

cd applications/${APP}
echo "🔍 Validating Terraform code in $WORKDIR..."
terraform init -backend-config="environments/${ENV}/backend.hcl"
terraform validate
terraform fmt -check -recursive
terraform plan -var-file="environments/${ENV}/${APP}.tfvars"
