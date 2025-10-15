#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="./.env"

declare -A TEAM_RANGES=(
  [Athena]="100.80.0.0/23"
  [BOREAS]="100.80.2.0/23"
  [Charon]="100.80.4.0/23"
  [DEMETER]="100.80.6.0/23"
)

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <TeamName> [RHOSTS] [RPORT]"
  echo "Teams: ${!TEAM_RANGES[@]}"
  exit 1
fi

TEAM="$1"
RHOSTS="${2:-}"
RPORT="${3:-}"

if [[ -z "${TEAM_RANGES[$TEAM]:-}" ]]; then
  echo "[!] Unknown team: $TEAM"
  exit 1
fi

# Build ATTACK_RANGES = all except selected team
ATTACK_RANGES=""
for t in "${!TEAM_RANGES[@]}"; do
  if [[ "$t" != "$TEAM" ]]; then
    ATTACK_RANGES+="${TEAM_RANGES[$t]} "
  fi
done
ATTACK_RANGES=$(echo "$ATTACK_RANGES" | xargs)  # trim

# Update .env in place
sed -i.bak \
  -e "s|^TEAM_NAME=.*|TEAM_NAME=$TEAM/|" \
  -e "s|^TEAM_RANGE=.*|TEAM_RANGE=${TEAM_RANGES[$TEAM]}|" \
  -e "s|^ATTACK_RANGES=.*|ATTACK_RANGES=$ATTACK_RANGES|" \
  -e "s|^RHOSTS=.*|RHOSTS=$RHOSTS|" \
  -e "s|^RPORT=.*|RPORT=$RPORT|" \
  "$ENV_FILE"

echo "[+] Updated .env for team $TEAM"
echo "    TEAM_RANGE=${TEAM_RANGES[$TEAM]}"
echo "    ATTACK_RANGES=$ATTACK_RANGES"
[[ -n "$RHOSTS" ]] && echo "    RHOSTS=$RHOSTS"
[[ -n "$RPORT" ]] && echo "    RPORT=$RPORT"
