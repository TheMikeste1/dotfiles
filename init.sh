#! /usr/bin/env bash
set -e

if ! [ -x "$(command -v ansible)" ]; then
    echo "Installing Ansible..."
    sudo apt update
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
fi

ansible-playbook --ask-become-pass initialize.yml

