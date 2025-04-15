#!/bin/bash
# Simulate code changes to trigger pipelines
echo "TEST[$(date +%s)]" > testfile.txt
git add . && git commit -m "TEST: Trigger pipelines"
git push origin main

# Monitor pipeline status
while true; do
  STATUS=$(glab api /projects/$CI_PROJECT_ID/pipelines | jq '.[0].status')
  echo "Pipeline status: $STATUS"
  [ "$STATUS" != \"running\" ] && break
  sleep 10
done