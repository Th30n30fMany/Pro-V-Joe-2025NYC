#!/bin/bash
# pcap_beacons.sh <pcap-file>
PCAP="$1"
if [ -z "$PCAP" ]; then
  echo "Usage: $0 capture.pcap"
  exit 1
fi
tshark -r "$PCAP" -T fields -e ip.dst | grep -v '^$' | sort | uniq -c | sort -nr | head -n 50
