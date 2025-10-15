#!/usr/bin/env bash
# STIG_debian.sh - conservative baseline hardening for Debian/Ubuntu
# Run as root. Test in VM before deployment.
set -euo pipefail

LOG="/var/log/stig_debian_$(date -u +%Y%m%dT%H%M%SZ).log"
exec > >(tee -a "$LOG") 2>&1

echo "=== STIG Debian baseline starting ==="

# 0. Basic checks
if [ "$(id -u)" -ne 0 ]; then
  echo "Must be run as root"
  exit 1
fi

# 1. Update package lists and install essentials
echo "[1] Updating packages and installing required tooling"
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  ufw auditd apparmor apparmor-utils aide unattended-upgrades fail2ban rsyslog logrotate apt-transport-https gnupg

# 2. Create a rollback snapshot directory for modified configs
ROLLBACK="/var/backups/stig_debian_rollback_$(date -u +%Y%m%dT%H%M%SZ)"
mkdir -p "$ROLLBACK"
echo "[2] Backing up selected config files to $ROLLBACK"
for f in /etc/ssh/sshd_config /etc/fail2ban/jail.local /etc/ufw/ufw.conf /etc/apt/apt.conf.d/20auto-upgrades /etc/audit/auditd.conf /etc/default/grub; do
  [ -e "$f" ] && cp -a "$f" "$ROLLBACK/$(basename $f).orig"
done

# 3. SSH hardening
echo "[3] Hardening SSH"
SSHD="/etc/ssh/sshd_config"
cp -a "$SSHD" "$ROLLBACK/sshd_config.orig"
# Conservative set of secure options
sed -E -i 's/^[# ]*PermitRootLogin.*/PermitRootLogin no/' "$SSHD" || echo "PermitRootLogin no" >> "$SSHD"
sed -E -i 's/^[# ]*PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD" || echo "PasswordAuthentication no" >> "$SSHD"
sed -E -i 's/^[# ]*ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' "$SSHD" || echo "ChallengeResponseAuthentication no" >> "$SSHD"
sed -E -i 's/^[# ]*PermitEmptyPasswords.*/PermitEmptyPasswords no/' "$SSHD" || echo "PermitEmptyPasswords no" >> "$SSHD"
sed -E -i 's/^[# ]*PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSHD" || echo "PubkeyAuthentication yes" >> "$SSHD"
# Optional: limit ciphers (keep conservative default if unknown)
grep -q "^Ciphers" "$SSHD" || echo "Ciphers aes256-ctr,aes192-ctr,aes128-ctr" >> "$SSHD"
# Restart sshd
systemctl restart sshd

# 4. Firewall (ufw) - default deny incoming, allow necessary
echo "[4] Configuring UFW firewall"
ufw default deny incoming
ufw default allow outgoing
# Allow SSH (adjust if using non-standard port or management bastion)
ufw allow OpenSSH
ufw --force enable

# 5. Automatic security updates
echo "[5] Enabling unattended-upgrades for security updates"
cat > /etc/apt/apt.conf.d/20auto-upgrades <<'EOF'
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF
dpkg-reconfigure -f noninteractive unattended-upgrades || true

# 6. Auditd configuration (process and auth auditing)
echo "[6] Configuring auditd basic rules"
cp -a /etc/audit/audit.rules "$ROLLBACK/" 2>/dev/null || true
cat > /etc/audit/rules.d/stig.rules <<'EOF'
# login, logout, and authentication
-w /var/log/faillog -p wa -k logins
-w /var/log/lastlog -p wa -k logins
-w /var/log/auth.log -p wa -k auth
# monitor shadow and passwd changes
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/group -p wa -k identity
# monitor sudoers
-w /etc/sudoers -p wa -k scope
-w /etc/sudoers.d/ -p wa -k scope
# monitor important binaries
-a always,exit -F path=/usr/bin/sudo -F perm=x -k privileged
-a always,exit -F path=/usr/bin/ssh -F perm=x -k ssh_exec
EOF
augenrules --load || true
systemctl restart auditd

# 7. AppArmor enable and basic enforcement
echo "[7] Ensuring AppArmor is enabled and enforcing"
systemctl enable --now apparmor
# Set profiles to enforce where available
aa-enforce /etc/apparmor.d/* || true

# 8. Remove or disable legacy/unnecessary packages
echo "[8] Removing legacy or risky packages if present (telnet, rsh, talk)"
for pkg in telnetd rsh-server talk rsh-client rexec-server; do
  if dpkg -l | grep -qw "${pkg}"; then
    apt-get remove -y --purge "$pkg" || true
  fi
done

# 9. Password and PAM hardening (conservative)
echo "[9] Configuring password policies via PAM and login.defs"
# Ensure password aging and complexity via login.defs
cp -a /etc/login.defs "$ROLLBACK/login.defs.orig"
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   1/' /etc/login.defs
sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN    12/' /etc/login.defs || echo "PASS_MIN_LEN    12" >> /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   14/' /etc/login.defs

# Enforce lockout using pam_faillock if available (Debian/Ubuntu may use pam_tally2 or faillock)
if grep -q pam_faillock /etc/pam.d/common-auth 2>/dev/null || true; then
  echo "pam_faillock present; ensure configuration applied (manual review recommended)"
else
  # conservative fallback: install libpam-faildelay or pam-auth-update with faillock
  apt-get install -y libpam-failover libpam-pwquality || true
  # Append basic pam pwquality rule
  if ! grep -q pam_pwquality /etc/pam.d/common-password 2>/dev/null; then
    sed -i '1i password requisite pam_pwquality.so retry=3 minlen=12 difok=4' /etc/pam.d/common-password
  fi
fi

# 10. Enable fail2ban with a basic ssh jail
echo "[10] Configuring fail2ban for SSH"
cat > /etc/fail2ban/jail.local <<'EOF'
[DEFAULT]
bantime = 600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port = ssh
logpath = %(sshd_log)s
EOF
systemctl enable --now fail2ban

# 11. Enable AIDE file integrity (initialize database)
echo "[11] Initializing AIDE (file-integrity)"
AIDE_CONF="/etc/aide/aide.conf"
cp -a "$AIDE_CONF" "$ROLLBACK/aide.conf.orig" 2>/dev/null || true
aideinit || true
# move db to persistent path if created
if [ -e /var/lib/aide/aide.db.new.gz ]; then
  mv /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
fi

# 12. Sysctl hardening (network and kernel)
echo "[12] Applying sysctl kernel hardening"
SYSCTL_CONF="/etc/sysctl.d/99-stig.conf"
cat > "$SYSCTL_CONF" <<'EOF'
# Network hardening
net.ipv4.ip_forward = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.tcp_syncookies = 1
# IPv6
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.all.accept_ra = 0
net.ipv6.conf.default.accept_ra = 0
# Kernel
fs.protected_hardlinks = 1
fs.protected_symlinks = 1
EOF
sysctl --system

# 13. Restrict world-writeable directories and removable media automount
echo "[13] Locking down permissions and disabling automounts"
chmod -R o-w /tmp || true
# Disable automounts (if using systemd)
systemctl mask remote-fs.target || true

# 14. Logging rotation and rsyslog tuning (basic)
echo "[14] Ensuring rsyslog is running and logrotate present"
systemctl enable --now rsyslog
# ensure logrotate exists (installed earlier)

# 15. Minimal cron and at restriction - disable at if unused
echo "[15] Restricting at/cron where applicable"
systemctl disable --now atd || true

echo "=== STIG baseline hardening complete ==="
echo "Log of changes: $LOG"
echo "Rollback files: $ROLLBACK"
echo "Recommended manual checks: SSH key distribution (since password auth disabled), sudoers review, PAM policies review, AppArmor profile tuning, AIDE baseline verification."

exit 0
