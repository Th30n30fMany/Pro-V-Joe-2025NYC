#!/bin/bash
source ./libs/helpers.sh; safe scp
TARGET="${1:?Usage: $0 <target>}"
UUID=$(uuidgen)
TMP="/tmp/.cache_$UUID"
echo "https://intra.$(host_tag)/v2/$UUID" > "$TMP"
scp "$TMP" root@"$TARGET":/home/guest/.local/share/.cache_$UUID
rm -f "$TMP"
echo "$(ts) Reverse token dropped on $TARGET" >> /var/log/scorched.log
