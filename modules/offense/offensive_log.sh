#!/bin/bash
source ../../libs/helpers.sh
ACTION="${1:?Usage: $0 \"action text\"}"
echo "$(ts) [OFFENSE] $ACTION" >> /var/log/pvj_offense.log
