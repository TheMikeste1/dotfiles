#! /bin/env fish

function git --wraps git --description 'git wrapper to handle Windows paths'
  if pwd -P | grep -q "/mnt/[a-z]/*"
    echo "Windows path detected, using git.exe"
    git.exe $argv
  else
    command git $argv
  end
end;
