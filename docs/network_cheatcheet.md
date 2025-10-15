# Network Cheat Sheet

## CIDR Reference
| CIDR | Subnet Mask | Hosts |
|------|-------------|-------|
| /23  | 255.255.255.128 | 512 |
| /24  | 255.255.255.0 | 254 |
| /28  | 255.255.255.240 | 14 |
| /30  | 255.255.255.252 | 2 |

## Nmap Flags
- `-sn` : ping sweep
- `-sV` : service detection
- `--top-ports 200` : fast scan
- `-p-` : full TCP scan

## Linux Net Commands
- `ss -tunlp`
- `ip addr show`
- `ip route show`
- `arp -a`

## Triage Snippets
- `ps aux`
- `netstat -tulpen`
- `crontab -l`
- `find / -iname '*flag*'`
