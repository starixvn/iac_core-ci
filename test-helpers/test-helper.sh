#!/bin/bash
# Kích hoạt test workflow
set -x

# 1. Simulate IaC change
echo "resource \"null_resource\" \"test\" {}" > iac-test.tf
git add . && git commit -m "TEST[iac]: Add dummy resource"

# 2. Simulate EaC change
mkdir -p charts/test
echo "{ \"replicas\": 1 }" > charts/test/values.yaml
git add . && git commit -m "TEST[eac]: Add test chart"

# 3. Push to trigger
git push origin main

# 4. Monitor pipelines
glab pipeline ci list --status=running