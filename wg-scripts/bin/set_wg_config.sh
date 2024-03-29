#!/bin/bash -e

# If tun.conf file is empty or does not exist, populate as needed.
# See https://forum.snapcraft.io/t/raspberry-pi-3-ubuntu-core-18-network-control-interface-issue/14773/7
# for why this is needed (sometimes)
if [ ! -s /etc/modules-load.d/tun.conf ]; then
  echo 'tun' > /etc/modules-load.d/tun.conf
fi

echo 'Generating wg0.conf'

# Get MAC ID
MAC=$(cat /sys/class/net/eth0/address | sed s/://g)

# Generate IP address (based on last three bytes of MAC)
WG_LOCAL_IP="10.$((16#${MAC:6:2})).$((16#${MAC:8:2})).$((16#${MAC:10:2}))"

# Generate 32-byte WireGuard private key base64
WG_LOCAL_PRIVKEY=$(printf "%32s" "$MAC" | base64)

# WireGuard remote endpoint parameters
WG_REMOTE_PUBKEY='uneWvIm34XIkPyDP58XMZ1Ftsg7SzFVMt4EQeotJcRA='
WG_REMOTE_IP=10.255.255.254
WG_REMOTE_HOST=et-wg.ammp.io
WG_REMOTE_PORT=123

# Create WireGuard config file
cat > $SNAP_COMMON/wg0.conf <<EOL
[Interface]
PrivateKey = $WG_LOCAL_PRIVKEY
Address = $WG_LOCAL_IP/32

[Peer]
PublicKey = $WG_REMOTE_PUBKEY
AllowedIPs = $WG_REMOTE_IP/32
Endpoint = $WG_REMOTE_HOST:$WG_REMOTE_PORT
PersistentKeepalive = 25
EOL

chmod 600 $SNAP_COMMON/wg0.conf
