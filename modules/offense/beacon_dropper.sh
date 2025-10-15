#!/usr/bin/env bash
set -euo pipefail

: "${SCOREBOT_URL:=http://100.80.4.53:5000/beacon}"
: "${TEAM_NAME:=UnknownTeam}"
: "${HOSTNAME:=$(hostname)}"

if command -v uuidgen >/dev/null 2>&1; then
  UUID=$(uuidgen)
else
  UUID=$(python3 -c "import uuid; print(uuid.uuid4())")
fi

curl -s -X POST "$SCOREBOT_URL" \
  -d "team=$TEAM_NAME" \
  -d "host=$HOSTNAME" \
  -d "uuid=$UUID"
