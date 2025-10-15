#!/bin/bash
source ../../libs/helpers.sh; safe tshark
PCAP="${1:?Usage: $0 <pcap_file>}"
tshark -r "$PCAP" -T fields -e ip.dst | sort | uniq -c | sort -nr | head
