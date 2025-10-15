#!/bin/bash
source ./libs/helpers.sh
OUT=$(log_dir "baseline_$(host_tag)")
uname -a > "$OUT/uname.txt"
ps aux > "$OUT/ps.txt"
ss -tunlp > "$OUT/ss.txt"
cat /etc/passwd > "$OUT/passwd.txt"
echo "[+] Baseline in $OUT"
