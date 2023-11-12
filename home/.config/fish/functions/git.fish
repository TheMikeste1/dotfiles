#! /bin/env fish

function git --wraps git --description 'git wrapper to handle Windows paths'
  if pwd -P | grep -q "/mnt/[a-z]/*"
    git.exe $argv
  else
    command git $argv
  end
end;
