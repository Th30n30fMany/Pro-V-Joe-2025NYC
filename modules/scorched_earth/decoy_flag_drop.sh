#!/bin/bash
source ./libs/helpers.sh; require_root
DIR="/var/www/html/.assets/.archive"
mkdir -p "$DIR"
UUID=$(uuidgen)
echo "ARCHIVE-$UUID" > "$DIR/.doc_$UUID.tmp"
touch "$DIR/.index.lock"
echo "[+] Subtle decoy placed in $DIR"
# echo "$(ts) Decoy flag dropped" >> /var/log/scorched.log