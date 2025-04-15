#!/bin/bash
set -eo pipefail

echo "Syncing ArgoCD applications"
for app in $(ls argocd/apps); do
  argocd app sync $app --server $ARGOCD_SERVER --auth-token $ARGOCD_TOKEN
done