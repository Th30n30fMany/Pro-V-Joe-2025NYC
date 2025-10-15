#!/usr/bin/env bash
set -euo pipefail
LOG="/var/log/stig_centos_$(date -u +%Y%m%dT%H%M%SZ).log"
exec > >(tee -a "$LOG") 2>&1

ROLLBACK="/var/backups/stig_centos_rollback_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$ROLLBACK"

# 1. Update & install
yum update -y
yum install -y epel-release
yum install -y firewalld audit aide fail2ban rsyslog logrotate

# 2. Backup configs
for f in /etc/ssh/sshd_config /etc/firewalld/firewalld.conf /etc/audit/auditd.conf; do
  [ -e "$f" ] && cp -a "$f" "$ROLLBACK/"
done

# 3. SSH hardening
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# 4. Firewall
systemctl enable --now firewalld
firewall-cmd --set-default-zone=drop
firewall-cmd --permanent --add-service=ssh
firewall-cmd --reload

# 5. Auditd
systemctl enable --now auditd
cat > /etc/audit/rules.d/stig.rules <<'EOF'
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
EOF
augenrules --load

# 6. AIDE
aide --init || true
mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz || true

# 7. Sysctl
cat > /etc/sysctl.d/99-stig.conf <<'EOF'
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_redirects = 0
fs.protected_hardlinks = 1
EOF
sysctl --system
