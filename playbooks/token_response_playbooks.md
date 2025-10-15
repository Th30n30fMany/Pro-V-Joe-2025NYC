# Token Response Playbooks

HTTP token hit
1. Identify token_id and placement in registry.
2. Copy the hit entry to forensics area.
3. Run host_snapshot.sh against suspect host; store output in central forensics.
4. If internal source, apply ACL block and execute relevant triage script.
5. Notify Team Lead and update incident log.

SSH key usage
1. Block source IP at firewall
2. Collect authentication logs and authorized_keys
3. Rotate any in-scope credentials
4. If interactive shell suspected, isolate and escalate for live response
