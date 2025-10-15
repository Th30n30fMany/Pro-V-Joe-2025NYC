#!/bin/bash
OUT="/tmp/pvj_triage_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$OUT"
ss -tunp > "$OUT/ss.txt"
ps aux > "$OUT/ps.txt"
crontab -l > "$OUT/crontab.txt" 2>/dev/null || true
ls -la /home > "$OUT/home_list.txt"
tar -czf "/tmp/pvj_triage_bundle.tgz" -C "$(dirname $OUT)" "$(basename $OUT)"
echo "/tmp/pvj_triage_bundle.tgz"
