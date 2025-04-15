#!/bin/bash
set -e

WORKDIR=$1

cd "$WORKDIR"
echo "🔍 Validating Terraform code in $WORKDIR..."
terraform init -backend=false
terraform validate
