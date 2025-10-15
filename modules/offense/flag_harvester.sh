#!/bin/bash
source ./libs/helpers.sh; safe ssh
TARGET="${1:?Usage: $0 <target>}"
OUT=$(log_dir "flags_${TARGET}")
ssh root@"$TARGET" "find / -type f -iregex '.*/.*flag.*' -size -64k -exec strings {} \;" > "$OUT/flags.txt" || true
echo "[+] Flags saved to $OUT/flags.txt"
