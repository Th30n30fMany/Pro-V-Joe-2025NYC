#!/bin/bash
# forward_hits.sh - batch-forward canary logs to analysis VM
SRC="/var/log/canary_hits.log"
DEST_USER="analyst"
DEST_HOST="100.80.4.10"
DEST_PATH="/var/forensics/canary/"
TMP="/tmp/canary_forward.tmp"
mkdir -p /tmp
tail -n 1000 "$SRC" > "$TMP"
scp "$TMP" "${DEST_USER}@${DEST_HOST}:${DEST_PATH}$(hostname)-$(date -u +%s).log" && rm -f "$TMP"
