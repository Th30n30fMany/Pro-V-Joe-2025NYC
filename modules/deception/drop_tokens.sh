#!/bin/bash
source ./libs/helpers.sh
USER="${1:?Usage: $0 <user>}"
if command -v uuidgen >/dev/null 2>&1; then
  UUID=$(uuidgen)
else
  UUID=$(python3 -c "import uuid; print(uuid.uuid4())")
fi
BASE="/home/$USER/.config/.cache/.sync"
mkdir -p "$BASE"
echo "ssh-rsa AAAA... $UUID" > "$BASE/.id_rsa.pub"
echo "http://127.0.0.1:5000/beacon/" > "$BASE/.note"
chmod 600 "$BASE/.id_rsa.pub"
echo "[+] Subtle tokens placed under $BASE"
