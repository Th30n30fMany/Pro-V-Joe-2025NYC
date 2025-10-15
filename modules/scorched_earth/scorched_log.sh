#!/bin/bash
source ./libs/helpers.sh
ACTION="${1:?Usage: $0 \"action text\"}"
echo "$(ts) [SCORCHED] $ACTION" >> /var/log/pvj_scorched.log
