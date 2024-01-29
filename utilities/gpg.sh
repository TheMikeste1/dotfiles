#!/bin/sh

echo "Warning: gpg.sh is deprecated. Update your gpg-agent.conf to use a gui agent instead." >&2
if [ -n "$FUGITIVE" ]; then
  true
  # set -- --pinentry-mode loopback "$@"
fi
exec /usr/bin/gpg "$@"
