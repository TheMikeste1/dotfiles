#! /bin/env fish

function explorer
  if ! pushd "$argv[1]" &> /dev/null
    echo "couldn't find directory \"$argv[1]\"";
    return;
  end;
  explorer.exe .
  popd &> /dev/null || return;
end;
