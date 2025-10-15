#!/bin/bash
# pvj_lockdown.sh - snapshot + quick hardening (safe minimal changes)
set -euo pipefail
LOGDIR="/var/log/pvj_triage_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$LOGDIR"
ss -tunlp > "$LOGDIR/ss_before.txt" 2>/dev/null || netstat -tulnp > "$LOGDIR/netstat_before.txt" 2>/dev/null || true
ps aux > "$LOGDIR/ps_before.txt"
# preserve baseline if present
cp -a /etc "$LOGDIR/etc_snapshot" 2>/dev/null || true
# disable clearly risky services (documented)
for svc in telnet ftp vsftpd rpcbind; do
  if systemctl list-unit-files | grep -q "^${svc}"; then
    systemctl stop $svc || true
    systemctl disable $svc || true
    echo "disabled $svc" >> "$LOGDIR/actions.txt"
  fi
done
# firewall: keep ssh, deny incoming otherwise
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable
echo "Lockdown applied; snapshots and actions in $LOGDIR"
