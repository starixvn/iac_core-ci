#!/bin/bash
set -eo pipefail

echo "Linting Ansible playbooks"
ansible-lint ansible/playbooks/*.yml