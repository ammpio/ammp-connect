#!/bin/sh
 
# Load configuration options
. "$SNAP"/config

while true; do

  # Check if process is running already
  if [ $(ps | grep -v grep | grep -v "\.sh" | grep ssh | grep ExitOnForwardFailure | wc -l) -eq 0 ]; then
    # If not running, start it up
    "$SNAP"/usr/bin/ssh -o ExitOnForwardFailure=yes -o ConnectTimeout=60 -o ServerAliveInterval=10 -o ServerAliveCountMax=3 -o TCPKeepAlive=yes -o StrictHostKeyChecking=yes -o UserKnownHostsFile="$KNOWN_HOSTS" -p "$PORT" -N -R 0.0.0.0:0:localhost:22 -i "$PRIV_KEY" -f "$USER"@"$REMOTE"
  fi

  # Wait a little
  sleep 10m
done
