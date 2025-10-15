#!/bin/bash
# ssh_socks_proxy.sh
# Automates reverse tunnel + SOCKS proxy setup for lab/assessment use
# Usage: ./ssh_socks_proxy.sh <server_host> <server_port> <server_user> <client_user>

SERVER_HOST="${1:-server.acme.org}"
SERVER_PORT="${2:-65022}"
SERVER_USER="${3:-xavier}"
CLIENT_USER="${4:-xavier}"

# Paths
KEY="${HOME}/.ssh/privatekey"
SOCKS_PORT=1080
REVERSE_PORT=2222

echo "[*] Starting reverse tunnel from client to server..."
ssh -f -N -i "$KEY" -p "$SERVER_PORT" -R ${REVERSE_PORT}:localhost:22 ${SERVER_USER}@${SERVER_HOST}

echo "[*] Opening second session to server..."
ssh -f -N -i "$KEY" -p "$SERVER_PORT" ${SERVER_USER}@${SERVER_HOST} \
    "ssh -f -N -p ${REVERSE_PORT} -D ${SOCKS_PORT} ${CLIENT_USER}@localhost"

echo "[*] Exporting proxy environment variables..."
export http_proxy="socks5h://127.0.0.1:${SOCKS_PORT}"
export https_proxy="socks5h://127.0.0.1:${SOCKS_PORT}"

echo "[+] Proxy setup complete."
echo "    Test with: curl https://ipinfo.io/"
