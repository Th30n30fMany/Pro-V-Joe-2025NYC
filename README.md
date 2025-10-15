# PvJ Defensive Playbook
Modular, PvJ-compliant toolkit for discovery, triage, deception, offense, and Scorched Earth. Kali Purple-ready, with orchestrator, helpers, and playbooks.

Usage model:
- Clone repo to central analyst VM
- Deploy infra/canary-receiver as Docker or systemd service
- Distribute token artifacts to target hosts
- Run tools/triage-scripts during event for rapid response

Structure overview:
- infra: canary receiver, DNS stub, registry
- tools: token management, triage and lockdown scripts, forwarders, auto-triage
- playbooks: operational playbooks for pregame, first 15 minutes, triage, tokens, evidence
- docs: roles, token placement map, quick reference

## Quickstart
make setup
python3 pvj_runner.py --scan 100.80.0.0/23
python3 pvj_runner.py --recon 100.80.2.5
python3 pvj_runner.py --exploit 100.80.2.5 exploit/linux/samba/is_known_pipename
python3 pvj_runner.py --beacon

## Notes
- Keep services available; do not block IPs or disable remote access.
- DNS + ICMP required for Scorebot scoring.
- Log and preserve evidence; triage before remediation.

# PvJ Defensive Playbook 

A modular, PvJ-compliant toolkit for **Blue Team defense, offense, and Scorched Earth** phases at BSides NYC 2025 and beyond.  
Built for **Kali Purple**, with orchestrator, helpers, deception, and evidence-first workflows.

---

## Features
-  Discovery & Recon (nmap, dig, whois)
-  Incident Response (Linux/Windows triage)
-  Deception (subtle tokens, canary receiver)
-  Offense (Metasploit runner, beacon dropper, flag harvester)
-  Scorched Earth (decoys, reverse tokens, fake listeners)
-  Red Team Tools (Responder, Hydra workflows)
-  Playbooks (pregame → triage → deception → scorched)
-  Docs (roles, cheat sheets, StrandJS alignment)

---

## Quickstart
```bash
git clone https://github.com/<your-org>/pvj-defensive-playbook.git
cd pvj-defensive-playbook
./bootstrap.sh
make setup
