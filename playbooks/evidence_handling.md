# Evidence Handling

- Always collect before remediation when possible
- Label bundles with token_id, host, timestamp, collector
- Store originals in read-only storage and analyze copies
- Compute SHA256 for each bundle and store a manifest
- Maintain chain-of-custody notes in incident log

## Goals
- Preserve forensic artifacts
- Maintain chain of custody
- Enable post-game review

## Steps
1.  Store all outputs in `/var/forensics/<type>_<ts>`
2.  Hash and label each bundle
3.  Record timestamps and operator ID
4.  Use `offensive_log.sh` and `scorched_log.sh` for tracking
5.  Share findings during hotwash


