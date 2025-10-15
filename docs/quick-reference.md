# Quick Reference

- Run discovery: tools/discovery/nmap_scan.sh <cidr>
- Per-host enum: tools/discovery/host_enumeration.sh <ip>
- Capture baseline: tools/discovery/baseline_capture.sh <outdir>
- Create token: tools/token-management/create_token.sh <name> <type> <host> <placement> <priority>
- Canary receiver: infra/canary-receiver/app/canary_receiver.py (run via Dockerfile or systemd unit)
- Quick lockdown: tools/triage-scripts/pvj_lockdown.sh
- Snapshot host: tools/triage-scripts/host_snapshot.sh
- Multi-SSH Connections: parallel-ssh -A -i -h sshhosts df -h
