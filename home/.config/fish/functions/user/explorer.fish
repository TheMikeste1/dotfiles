#! /bin/env fish

function explorer --wraps explorer.exe --description 'Open Windows Explorer in the current directory'
  if ! pushd "$argv[1]" &> /dev/null
    echo "couldn't find directory \"$argv[1]\"";
    return;
  end;
  explorer.exe .
  popd &> /dev/null || return;
end;
