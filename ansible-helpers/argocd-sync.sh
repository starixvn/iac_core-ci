#!/bin/bash
set -e

APP_NAME=$1
ARGOCD_SERVER=$2
ARGOCD_TOKEN=$3

echo "🔄 Syncing ArgoCD application $APP_NAME..."
argocd app sync "$APP_NAME" --server "$ARGOCD_SERVER" --auth-token "$ARGOCD_TOKEN" --insecure
