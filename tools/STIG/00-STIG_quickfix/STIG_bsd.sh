#!/bin/sh
LOG="/var/log/stig_bsd_$(date -u +%Y%m%dT%H%M%SZ).log"
exec > "$LOG" 2>&1
ROLLBACK="/var/backups/stig_bsd_rollback_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$ROLLBACK"

# 1. Update
pkg update -f
pkg upgrade -y
pkg install -y aide auditd

# 2. SSH hardening
cp /etc/ssh/sshd_config "$ROLLBACK/"
sed -i '' 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i '' 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
service sshd restart

# 3. Audit
echo 'auditd_enable="YES"' >> /etc/rc.conf
service auditd start

# 4. AIDE
aide --init
mv /var/db/aide/aide.db.new /var/db/aide/aide.db
