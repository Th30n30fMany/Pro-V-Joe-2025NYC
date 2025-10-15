#!/bin/bash
source ./libs/helpers.sh; require_root
OUT=$(log_dir "triage_$(host_tag)")
ps aux > "$OUT/ps.txt"
ss -tunlp > "$OUT/ss.txt"
for f in /etc/crontab /etc/cron.*/*; do [ -f "$f" ] && cp "$f" "$OUT"/; done
journalctl -n 500 > "$OUT/journal_tail.txt"
echo "[+] Triage in $OUT"
