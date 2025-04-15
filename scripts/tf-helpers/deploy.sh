#!/bin/bash
set -eo pipefail

if [ "$CI_COMMIT_BRANCH" == "$CI_DEFAULT_BRANCH" ]; then
  echo "Applying Terraform changes for ${APP} in ${ENVIRONMENT}"
  terraform apply -auto-approve tfplan
else
  echo "Skipping deploy for non-default branch"
fi