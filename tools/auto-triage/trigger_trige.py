#!/usr/bin/env python3
# trigger_triage.py <json_event>
import sys, json, subprocess, os, tempfile, datetime
if len(sys.argv) < 2:
    sys.exit(1)
event = json.loads(sys.argv[1])
token = event.get("token_id","unknown")
host = event.get("args",{}).get("host", event.get("remote"))
ts = datetime.datetime.utcnow().strftime("%Y%m%dT%H%M%SZ")
outdir = f"/var/forensics/{token}_{ts}"
os.makedirs(outdir, exist_ok=True)
# minimal: attempt ssh-run of triage script if host reachable
triage_script = "/opt/pvj/tools/auto-triage/triage_scripts/linux_triage.sh"
try:
    cmd = ["ssh", "-o", "BatchMode=yes", f"root@{host}", "bash -s"]
    with open(triage_script, "rb") as fh:
        subprocess.run(cmd, input=fh.read(), timeout=60)
except Exception:
    # fallback: log event and create placeholder
    with open(os.path.join(outdir, "event.json"), "w") as f:
        json.dump(event, f)
