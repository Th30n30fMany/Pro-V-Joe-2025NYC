#!/bin/bash
OUT="/var/forensics/host_snapshot_$(hostname)_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$OUT"
ss -tunp > "$OUT/ss.txt"
ps aux > "$OUT/ps.txt"
df -h > "$OUT/df.txt"
last -n 50 > "$OUT/last.txt" || true
tar -czf "${OUT}.tgz" -C "$(dirname $OUT)" "$(basename $OUT)"
echo "snapshot: ${OUT}.tgz"
