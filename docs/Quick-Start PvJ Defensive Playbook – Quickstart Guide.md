# PvJ Defensive Playbook – Quickstart Guide

## 1. Get the Repository

Clone the repo onto your assessment or competition workstation:

bash

```
git clone https://github.com/<your-org>/pvj-defensive-playbook.git
cd pvj-defensive-playbook
```

## 2. Prep the Device

### Linux (Ubuntu/Debian/CentOS/BSD)

- Ensure you are running as **root** or with `sudo`.
    
- Update the system and install base packages:
    

bash

```
# Debian/Ubuntu
sudo apt-get update -y
sudo apt-get install -y git make python3 python3-pip

# CentOS/RHEL
sudo yum update -y
sudo yum install -y git make python3 python3-pip
```

- Run the bootstrap script to install required tools (nmap, auditd, aide, fail2ban, responder, hydra, etc.):
    

bash

```
./bootstrap.sh
make setup
set -a; . ./.env; set +a

```

- Review and edit `.env` to set your **TEAM_NAME**, **SCOREBOT_URL**, and **NET_IFACE**.
    

### Windows (Server 2012/2016/2019, Windows 7)

- Install **PowerShell 5+**.
    
- Ensure you have Administrator rights.
    
- Place the `stig_windows.ps1` script in `C:\Scripts\`.
    
- Run from an elevated PowerShell prompt:
    

powershell

```
Set-ExecutionPolicy RemoteSigned -Force
.\stig_windows.ps1
```

##  3. High‑Level Workflow

### Pregame

- Connect to VPN and verify IP assignment.
    
- Confirm access to all assigned hosts.
    
- Run baseline capture:
    

bash

```
./modules/discovery/baseline_capture.sh
```

- Store outputs under `/var/forensics/baseline_<timestamp>/`.
    

### First 15 Minutes

- Run discovery scans:
    

bash

```
python3 pvj_runner.py --scan 100.80.0.0/23
```

- Deploy deception tokens:
    

bash

```
python3 pvj_runner.py --drop-token analyst
```

- Start monitoring hits:
    

bash

```
./modules/deception/monitor_hits.sh
```

- Enable firewall, auditd, fail2ban, and AIDE.
    

### Triage & Hunt

- Watch logs and token hits.
    
- Run triage scripts on suspect hosts:
    

bash

```
python3 pvj_runner.py --triage
```

- Use `beacon_detect.sh` on captured pcaps.
    

### Offensive Phase

- Recon a target:
    

bash

```
python3 pvj_runner.py --recon 100.80.2.5
```

- Launch exploit:
    

bash

```
python3 pvj_runner.py --exploit 100.80.2.5 exploit/linux/samba/is_known_pipename
```

- Drop beacon and harvest flags:
    

bash

```
python3 pvj_runner.py --beacon
python3 pvj_runner.py --harvest 100.80.2.5
```

- Log all actions:
    

bash

```
python3 pvj_runner.py --log "Exploit run on 100.80.2.5"
```

### Scorched Earth

- Deploy decoy flags:
    

bash

```
python3 pvj_runner.py --decoy-flag
```

- Drop reverse tokens:
    

bash

```
python3 pvj_runner.py --reverse-token 100.80.2.5
```

- Disable non‑scoring services:
    

bash

```
python3 pvj_runner.py --disrupt apache2
```

- Start fake listeners:
    

bash

```
python3 pvj_runner.py --countermeasures
```

##  4. Evidence Handling

- All outputs are stored under `/var/forensics/<phase>_<timestamp>/`.
    
- Logs:
    
    - Offensive: `/var/log/pvj_offense.log`
        
    - Scorched: `/var/log/pvj_scorched.log`
        
- Preserve artifacts for hotwash and after‑action review.
    

##  5. Reminders

- Do **not** block IPs or disable remote access.
    
- Always log before and after major actions.
    
- Test scripts in a VM before deploying to production hosts.
    
- Manual review required for:
    
    - SSH key distribution
        
    - PAM/sudoers policies
        
    - AppArmor/SELinux profile tuning
        
    - AIDE baseline verification