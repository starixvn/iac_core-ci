#!/bin/bash
set -eo pipefail

APP=$1

cd "applications/$APP"
terraform init -backend=false
terraform validate
terraform fmt -check -diff -no-color

# Security scan
docker run --rm -v $(pwd):/src aquasec/tfsec /src --exclude-downloaded-modules