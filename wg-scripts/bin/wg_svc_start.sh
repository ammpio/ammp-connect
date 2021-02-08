#!/bin/bash
check_wg_config.sh

until wg-quick up wg0; do
  echo 'Failed to set up WireGuard interface, retrying in 60 seconds...'
  sleep 60
done