#!/usr/bin/env python3
"""
pvj_runner.py - PvJ CTF script orchestrator for Blue Team operations
Supports discovery, triage, deception, offense, and scorched workflows
Run with: python3 pvj_runner.py --help
"""

import subprocess
import argparse
import os
from datetime import datetime, timezone

# Base paths
MODULES_DIR = "./modules"
LOG_DIR = "/var/forensics/runner_logs"
os.makedirs(LOG_DIR, exist_ok=True)

def timestamp():
    return datetime.now(timezone.utc)

def run_script(script_path, args=None):
    cmd = [script_path] + (args if args else [])
    print(f"[+] Running: {' '.join(cmd)}")
    try:
        subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
        print(f"[!] Error: {e}")

def log_action(action):
    with open(f"{LOG_DIR}/runner_{timestamp()}.log", "a") as f:
        f.write(f"{timestamp()} :: {action}\n")

def main():
    parser = argparse.ArgumentParser(description="PvJ Blue Team Workflow Runner")
    parser.add_argument("--scan", help="Run nmap_scan.sh with CIDR or file")
    parser.add_argument("--triage", action="store_true", help="Run linux_triage.sh on local host")
    parser.add_argument("--recon", help="Run target_recon.sh on target IP")
    parser.add_argument("--exploit", nargs=2, metavar=("TARGET", "MODULE"), help="Run exploit_runner.sh")
    parser.add_argument("--beacon", action="store_true", help="Run beacon_dropper.sh")
    parser.add_argument("--harvest", help="Run flag_harvester.sh on target IP")
    parser.add_argument("--drop-token", help="Run drop_tokens.sh on user")
    parser.add_argument("--reverse-token", help="Run reverse_token.sh on target IP")
    parser.add_argument("--decoy-flag", action="store_true", help="Run decoy_flag_drop.sh")
    parser.add_argument("--disrupt", help="Run service_disruptor.sh on service name")
    parser.add_argument("--countermeasures", action="store_true", help="Run offensive_countermeasures.sh")
    parser.add_argument("--log", help="Log custom action to offensive_log.sh")
    args = parser.parse_args()

    if args.scan:
        run_script(f"{MODULES_DIR}/discovery/nmap_scan.sh", [args.scan])
        log_action(f"Discovery scan on {args.scan}")
    elif args.triage:
        run_script(f"{MODULES_DIR}/ir/linux_triage.sh")
        log_action("Linux triage run")
    elif args.recon:
        run_script(f"{MODULES_DIR}/offense/target_recon.sh", [args.recon])
        log_action(f"Recon on {args.recon}")
    elif args.exploit:
        run_script(f"{MODULES_DIR}/offense/exploit_runner.sh", [args.exploit[0], args.exploit[1]])
        log_action(f"Exploit launched on {args.exploit[0]} using {args.exploit[1]}")
    elif args.beacon:
        run_script(f"{MODULES_DIR}/offense/beacon_dropper.sh")
        log_action("Beacon dropped")
    elif args.harvest:
        run_script(f"{MODULES_DIR}/offense/flag_harvester.sh", [args.harvest])
        log_action(f"Flag harvesting on {args.harvest}")
    elif args.drop_token:
        run_script(f"{MODULES_DIR}/deception/drop_tokens.sh", [args.drop_token])
        log_action(f"Token dropped for user {args.drop_token}")
    elif args.reverse_token:
        run_script(f"{MODULES_DIR}/scorched_earth/reverse_token.sh", [args.reverse_token])
        log_action(f"Reverse token dropped on {args.reverse_token}")
    elif args.decoy_flag:
        run_script(f"{MODULES_DIR}/scorched_earth/decoy_flag_drop.sh")
        log_action("Decoy flag dropped")
    elif args.disrupt:
        run_script(f"{MODULES_DIR}/scorched_earth/service_disruptor.sh", [args.disrupt])
        log_action(f"Service {args.disrupt} disrupted")
    elif args.countermeasures:
        run_script(f"{MODULES_DIR}/scorched_earth/offensive_countermeasures.sh")
        log_action("Countermeasures deployed")
    elif args.log:
        run_script(f"{MODULES_DIR}/offense/offensive_log.sh", [args.log])
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
