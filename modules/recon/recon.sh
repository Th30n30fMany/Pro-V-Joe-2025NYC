#!/bin/bash
source ./libs/helpers.sh; safe nmap; safe dig; safe whois
TARGET="${1:?Usage: $0 <target>}"
OUT=$(log_dir "recon_${TARGET}")
nmap -sV -T4 --top-ports 200 -oN "$OUT/nmap.txt" "$TARGET"
dig "$TARGET" any > "$OUT/dns.txt"
whois "$TARGET" > "$OUT/whois.txt"
echo "[+] Recon in $OUT"
