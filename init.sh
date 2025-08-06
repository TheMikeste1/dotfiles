#! /usr/bin/env bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
    echo "Installing Ansible..."
    pip install ansible
    ansible-galaxy collection install community.general
fi

ansible-playbook --ask-become-pass initialize.yaml
