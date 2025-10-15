#!/bin/bash
source ./libs/helpers.sh; load_env; safe nmap
CIDR="${1:?Usage: $0 <CIDR>}"
OUT=$(log_dir "discovery")
echo "[*] Host sweep ${CIDR}"
nmap -sn -PE -T4 "$CIDR" -oG "$OUT/hosts.gnmap"
echo "[*] Top ports ${CIDR}"
nmap -sV -T4 --top-ports 200 "$CIDR" -oN "$OUT/services.txt"
ip -4 addr show > "$OUT/ip_addr.txt"
ip route show > "$OUT/ip_route.txt"
arp -a > "$OUT/arp.txt"
echo "[+] Outputs in $OUT"
