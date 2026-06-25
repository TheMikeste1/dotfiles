#!/usr/bin/env bash
script_dir="$(dirname -- "${BASH_SOURCE[0]:-$0}")" && readonly script_dir
cd "$script_dir" || exit 1

current_origin="$(git remote get-url origin)"
declare -r current_origin
if [[ "$current_origin" == "git@"* ]]
then
  echo "Origin URL already set to SSH: $current_origin"
  exit 0
fi

domain="${current_origin#https://}"
declare -r path="${domain#*/}"
domain="${domain%%/*}"
declare -r domain
declare -r ssh_url="git@$domain:$path"
echo "Setting origin URL to $ssh_url"
git remote set-url origin "$ssh_url"
