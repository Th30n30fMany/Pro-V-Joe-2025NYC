#!/bin/bash
# create_token.sh <name> <type> <host> <placement> <priority>
set -e
NAME="$1"; TYPE="$2"; HOST="$3"; PLACEMENT="$4"; PRIORITY="${5:-low}"
REG="/opt/pvj/infra/registry/registry.csv"
UUID=$(uuidgen)
TS=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "$UUID,$NAME,$TYPE,$HOST,$PLACEMENT,$PRIORITY,${USER:-runner},$TS" >> "$REG"
if [ "$TYPE" = "http" ]; then
  echo "http://canary.local:8080/canary/$UUID"
elif [ "$TYPE" = "sshkey" ]; then
  echo "SSH key created: id_rsa_$UUID in $PLACEMENT"
else
  echo "$UUID recorded"
fi
