#!/bin/bash
source ./libs/helpers.sh; require_root
SERVICE="${1:?Usage: $0 <service_name>}"
systemctl is-enabled "$SERVICE" >/dev/null 2>&1 || { echo "[!] $SERVICE not enabled"; exit 0; }
systemctl stop "$SERVICE" && systemctl disable "$SERVICE"
echo "$(ts) Service $SERVICE disabled (non-scoring)" >> /var/log/scorched.log
