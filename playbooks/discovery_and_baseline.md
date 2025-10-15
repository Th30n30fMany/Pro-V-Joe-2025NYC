# Discovery and Baseline Playbook

Goal: within the first 15-30 minutes produce an inventory and baseline so detection and remediation are faster and safer.

Steps
1. Host Discovery
   - Run tools/discovery/nmap_scan.sh against event CIDR(s).
   - Save outputs in /var/forensics/discovery_<ts>.

2. Per-host enumeration
   - For scoring hosts and any unknown hosts, run tools/discovery/host_enumeration.sh <ip>.
   - Record suspicious open ports, unusual banners, and shared resources.

3. Baseline capture
   - For each host type (web, db, file-share, windows-workstation) capture baseline using tools/discovery/baseline_capture.sh (run locally or remotely).
   - Commit baseline bundles to a read-only forensics area and compute sha256 sums.

4. Integrate canary tokens
   - Use token registry to place 1-3 tokens per host class.
   - Document in infra/registry/registry.csv with placement and priority.
   - Ensure canary-receiver is running and forwarders in place.

5. Analysis
   - Correlate discovery outputs with baseline hashes to detect unexpected files or services.
   - Mark hosts that require immediate hardening or isolation and hand to Host Lead.

Notes
- Keep a strict change log of any hardening applied during baseline to aid post-event analysis.
- Avoid mass changes; document snapshots prior to any modification.
