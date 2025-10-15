#!/bin/bash
PORT=4444  # Change this to your port
INPUT="OK.txt"  # File containing allowed IPs
while read ip; do
  sudo ufw allow from "$ip" to any port "$PORT" proto tcp
done < OK.txt
