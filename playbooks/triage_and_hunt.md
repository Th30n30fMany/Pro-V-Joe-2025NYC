# Triage and Hunt

- Beacon detection workflow: capture packets at choke points, summarize top endpoints
- Persistence workflow: run autoruns/registry checks, enumerate systemd/crontabs
- Containment: prefer ACL/VLAN isolation; preserve volatile evidence before remediation
- Use triage scripts to collect host bundles and forward to analysis host
- Maintain incident log and tag per-token evidence bundles

# Triage and Hunt
- Watch token hits + logs
- Run linux_triage.sh on suspect hosts
- Use beacon_detect.sh on pcaps
- Snapshot -> remediate; store bundles under /var/forensics
- Escalate to Lead; track evidence

