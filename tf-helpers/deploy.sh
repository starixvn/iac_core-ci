#!/bin/bash
set -e

WORKDIR=$1
TFVARS=$2

cd "$WORKDIR"
echo "🚀 Deploying Terraform code in $WORKDIR with vars: $TFVARS..."
terraform init
terraform plan -var-file="$TFVARS"
terraform apply -auto-approve -var-file="$TFVARS"