#!/bin/bash
set -eo pipefail

APP=${1:-all}

argocd login ${ARGOCD_SERVER} --username admin --password ${ARGOCD_ADMIN_PASSWORD}

case "$APP" in
  all)
    for app in argocd/apps/*; do
      argocd app sync $(basename $app) --grpc-web
      argocd app wait $(basename $app) --health --timeout 300
    done
    ;;
  *)
    argocd app sync $APP --grpc-web
    argocd app wait $APP --health --timeout 300
    ;;
esac