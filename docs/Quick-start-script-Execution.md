# PvJ Playbook – Script Execution Guide

##  Host / Analyst Workstation

Run these from **your own laptop or central analyst VM** (with VPN into the environment). They are ad‑hoc tools you trigger as needed.

- `pvj_runner.py` – Orchestrator for all modules. **Ad‑hoc**.
    
- `modules/discovery/nmap_scan.sh` – External discovery scans. **Ad‑hoc**.
    
- `modules/recon/recon.sh` – Target recon. **Ad‑hoc**.
    
- `modules/redteam/responder_workflow.sh` – Credential capture (if permitted). **Run on analyst box**, continuous during offensive phase.
    
- `modules/redteam/hydra_brute.sh` – Brute force testing. **Ad‑hoc**.
    

## Inside Each Team Server (Environment Hosts)

Run these **on the servers you are defending**. They harden, monitor, and log. Most should be installed once, then scheduled or left running.

- `modules/discovery/baseline_capture.sh` – Capture baseline state. **One‑time at pregame**.
    
- `modules/ir/linux_triage.sh` / `windows_ir.ps1` – Incident response triage. **Ad‑hoc** when compromise suspected.
    
- `modules/deception/drop_tokens.sh` – Deploy tokens. **One‑time early**, repeat as needed.
    
- `modules/deception/monitor_hits.sh` – Token hit monitor. **Run continuously** (daemon or scheduled task).
    
- `modules/beacon/beacon_detect.sh` – Detect outbound beacons. **Ad‑hoc** on captured pcaps.
    
- `modules/offense/beacon_dropper.sh` – Run **from compromised host** after exploitation.
    
- `modules/offense/flag_harvester.sh` – Run **from compromised host** to collect flags.
    
- `modules/scorched_earth/decoy_flag_drop.sh` – Deploy decoys. **Ad‑hoc** in final phase.
    
- `modules/scorched_earth/reverse_token.sh` – Drop reverse tokens. **Ad‑hoc** in final phase.
    
- `modules/scorched_earth/service_disruptor.sh` – Disable non‑scoring services. **Ad‑hoc** in final phase.
    
- `modules/scorched_earth/offensive_countermeasures.sh` – Fake listeners. **Ad‑hoc** in final phase.
    

## Scheduled / Continuous Tasks

Recommended to set up as **cron jobs (Linux)** or **Scheduled Tasks (Windows)**:

- **Auditd / audit rules** – Continuous (system service).
    
- **Fail2ban** – Continuous (system service).
    
- **AppArmor / SELinux** – Continuous (system service).
    
- **monitor_hits.sh** – Continuous (background process).
    
- **AIDE checks** – Nightly cron job.
    
- **health‑check.py** – Every 15 minutes via cron/Scheduled Task to confirm services are up.
    

##  Quick Rules of Thumb

- **Analyst box**: Recon, scanning, credential capture.
    
- **Defended servers**: Hardening, monitoring, deception, triage.
    
- **Compromised hosts**: Beacon dropper, flag harvester, reverse tokens.
    
- **Scheduled**: Monitoring (auditd, fail2ban, monitor_hits), integrity checks (AIDE), health‑check.