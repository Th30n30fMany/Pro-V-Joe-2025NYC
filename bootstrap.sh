#!/bin/bash
# Bootstrap setup for PvJ Defensive Playbook
set -euo pipefail

echo "[*] Installing dependencies..."
sudo apt-get update -y
sudo apt-get install -y nmap tshark dnsmasq netcat-* whois curl jq python3-venv python3-pip hydra responder
pip3 install flask gunicorn

echo "[*] Setting up environment..."
# cp -n .env.example .env || true
mkdir -p /var/forensics

echo "[*] Done. Edit .env and run 'make setup' to finalize."
