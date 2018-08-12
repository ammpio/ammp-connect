#!/bin/sh
 
# Load configuration options
. "$SNAP"/config

while true; do

  "$SNAP"/usr/bin/ssh -o ExitOnForwardFailure=yes -o ConnectTimeout=60 -o ServerAliveInterval=10 -o ServerAliveCountMax=3 -o TCPKeepAlive=yes -o StrictHostKeyChecking=yes -o UserKnownHostsFile="$KNOWN_HOSTS" -p "$PORT" -N -R 0:localhost:22 -i "$PRIV_KEY" "$USER"@"$REMOTE"

  # Wait a little if process exits
  sleep 1m
done
