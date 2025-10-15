#!/bin/bash
set -euo pipefail

load_env() {
  [ -f .env ] && export $(grep -v '^#' .env | xargs) || true
}

ts() { date -u +%Y%m%dT%H%M%SZ; }
host_tag() { hostname; }

log_dir() {
  local base="${LOG_ROOT:-/var/forensics}"
  mkdir -p "$base/$1_$(ts)"
  echo "$base/$1_$(ts)"
}

safe() {
  command -v "$1" >/dev/null 2>&1 || { echo "[!] Missing: $1"; exit 1; }
}

require_root() {
  [ "$(id -u)" -eq 0 ] || { echo "[!] Run as root"; exit 1; }
}
