# Key Windows Event IDs for Threat Hunting (DeepBlueCLI Focus)

|Event ID|Log Source|Meaning|Why It Matters|
|---|---|---|---|
|**4624**|Security|Successful logon|Look for unusual accounts, logon types (e.g. type 3 = network, type 10 = RDP)|
|**4625**|Security|Failed logon attempt|Password guessing / spraying detection|
|**4672**|Security|Special privileges assigned|Indicates admin‑level logon, privilege escalation|
|**4720**|Security|User account created|New accounts mid‑game = persistence or attacker foothold|
|**4722**|Security|User account enabled|Disabled accounts being re‑enabled by attacker|
|**4723 / 4724**|Security|Password change/reset|Unexpected resets = attacker persistence|
|**4728 / 4732 / 4756**|Security|User added to privileged group|Domain Admins, Local Admins, etc.|
|**4688**|Security|Process creation|Useful for spotting suspicious binaries or encoded PowerShell|
|**4697**|Security|Service installed|Attackers often install backdoor services|
|**7045**|System|New service installed|Same as above, but from System log|
|**4103 / 4104**|PowerShell|PowerShell script block logging|Detects encoded/obfuscated PowerShell commands|
|**Sysmon 1**|Sysmon|Process creation (enhanced)|If Sysmon is deployed, gives richer process details|

