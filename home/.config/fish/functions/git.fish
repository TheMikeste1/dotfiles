#! /bin/env fish

function git --wraps git
  if pwd -P | grep -q "/mnt/[cd]/*"
    git.exe $argv
  else
    command git $argv
  end
end;
