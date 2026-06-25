#!/usr/bin/env bash
script_dir="$(dirname -- "${BASH_SOURCE[0]:-$0}")" && readonly script_dir
cd "$script_dir" || exit 1

git_email="$(grep email "$HOME/.config/chezmoi/chezmoi.toml")"
git_email="${git_email#email =}"
git_email="${git_email##\"}"
echo $git_email
git_email="${git_email%\"}"
echo $git_email
# ssh-keygen -t ed25519 -C "your_email@example.com"
