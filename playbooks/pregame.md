# Pregame Checklist

- Inventory OS images and services; store baseline lists in git
- Build and test collector VM (tcpdump, tshark, Velociraptor, KAPE)
- Pre-seed token registry and create a small set of tokens for test
- Harden central infra: deploy canary receiver, dns stub, and forwarders
- Test triage: trigger 2 tokens from a controlled host and validate end-to-end
- Ensure comms channel and incident log file are ready

# Pregame Checklist
- VPN connected, IP verified
- Asset control confirmed (no changes)
- Run baseline_capture.sh
- Validate DNS + ICMP to Scorebot
- Roles assigned and comms tested
