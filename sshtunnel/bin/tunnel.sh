#!/bin/sh
 
# Load configuration options
. "$SNAP"/config

# Set AutoSSH parameters
export AUTOSSH_PATH="$SNAP"/usr/bin/ssh
export AUTOSSH_GATETIME=0
export AUTOSSH_DEBUG=1

"$SNAP"/usr/lib/autossh/autossh -M 0 -o ExitOnForwardFailure=yes -o ConnectTimeout=60 -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o TCPKeepAlive=yes -o StrictHostKeyChecking=yes -o UserKnownHostsFile="$KNOWN_HOSTS" -p "$PORT" -N -R 0:localhost:22 -i "$PRIV_KEY" -v "$USER"@"$REMOTE"
