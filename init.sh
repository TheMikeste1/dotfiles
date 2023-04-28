#!/usr/bin/env bash
set -e

function determine_installer() {
    if [ -f /etc/os-release ]; then
        # Load the distribution information
        . /etc/os-release

        case "$ID" in
            fedora|rhel|centos|rocky|alma)
                echo "dnf"
                return 0
                ;;
            debian|ubuntu|mint)
                echo "apt-get"
                ;;
            *)
                # Check ID_LIKE if ID didn't give a direct match
                if [[ "$ID_LIKE" == *"rhel"* ]] || [[ "$ID_LIKE" == *"fedora"* ]]; then
                    echo "dnf"
                    return 0
                elif [[ "$ID_LIKE" == *"debian"* ]]; then
                    echo "apt-get"
                    return 0
                else
                    echo "Unknown distribution: $ID" >&2
                fi
                ;;
        esac
    fi

    echo "Could not determine distribution (missing /etc/os-release)" >&2
    echo ""
    return 1
}

if ! [ -x "$(command -v ansible)" ]; then
    if ! [ -x "$(command -v pip)" ]; then
        if [ "$(which python3)" = /usr/bin/python3 ]; then
            echo "Installing pip for system..."
            installer="$(determine_installer)"
            if [[ -n "$installer" ]]; then
                sudo "$installer" install python3-pip
            else
                echo "Unable to install pip. Cannot determine OS." >&2
                exit 1
            fi
        else
            echo "Unable to install ansible. Pip is not installed for $(which python3)."
            exit 1
        fi
    fi

    echo "Installing Ansible..."
    python3 -m pip install --break-system-packages ansible
    ansible-galaxy collection install community.general
fi

ansible-playbook --ask-become-pass playbook.yml
