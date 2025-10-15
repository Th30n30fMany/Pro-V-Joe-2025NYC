#!/bin/bash
source ./libs/helpers.sh
OUT=$(log_dir "canary_hits")
tail -F /var/log/syslog | grep --line-buffered -E "canary|token|sync" | tee -a "$OUT/hits.log"
echo "[+] Monitoring hits, logging to $OUT/hits.log"