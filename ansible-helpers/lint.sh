#!/bin/bash
set -e

PLAYBOOK_DIR=$1

echo "🔍 Linting Ansible playbooks in $PLAYBOOK_DIR..."
ansible-lint "$PLAYBOOK_DIR"/*.yml
