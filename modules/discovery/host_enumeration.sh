#!/bin/bash
source ./libs/helpers.sh; safe ssh
HOST="${1:?Usage: $0 <host>}"
OUT=$(log_dir "enum_${HOST}")
ssh "$HOST" "ps aux" > "$OUT/ps.txt" || true
ssh "$HOST" "ss -tunlp" > "$OUT/ss.txt" || true
ssh "$HOST" "cat /etc/passwd" > "$OUT/passwd.txt" || true
echo "[+] Outputs in $OUT"
