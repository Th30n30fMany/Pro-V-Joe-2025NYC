# Quick Setup: DeepBlueCLI on Kali

1. **Install prerequisites**
    
    bash
    
    ```
    sudo apt update
    sudo apt install -y git powershell
    ```
    
2. **Clone the repo**
    
    bash
    
    ```
    git clone https://github.com/sans-blue-team/DeepBlueCLI.git
    cd DeepBlueCLI
    ```
    
3. **Test run**
    
    bash
    
    ```
    pwsh ./DeepBlue.ps1 -h
    ```
    
    If you see usage/help output, you’re good.
    

# Workflow: Using DeepBlueCLI

### 1. **Process a local** `.evtx` **file**

bash

```
pwsh ./DeepBlue.ps1 ./evtx/Security.evtx
```

- Replace with the path to your event log file.
    
- Output will highlight suspicious logon attempts, account creation, PowerShell abuse, etc.
    

### 2. **Process multiple logs**

bash

```
pwsh ./DeepBlue.ps1 ./evtx/*.evtx > deepblue_output.txt
```

- Redirect to a file for later review.
    

### 3. **Analyze specific log types**

bash

```
# Security log
pwsh ./DeepBlue.ps1 -log security

# System log
pwsh ./DeepBlue.ps1 -log system
```

### 4. **Common detections you’ll see**

- Password guessing / spraying
    
- Suspicious account creation
    
- Lateral movement attempts
    
- Encoded/obfuscated PowerShell commands
    
- BloodHound‑style privilege escalation
    

# Suggested Gameday Workflow

1. **Collect logs** from compromised Windows hosts:
    
    powershell
    
    ```
    wevtutil epl Security Security.evtx
    wevtutil epl System System.evtx
    ```
    
    (Run on the Windows box, then exfiltrate to Kali.)
    
2. **Run DeepBlueCLI** on Kali against those `.evtx` files:
    
    bash
    
    ```
    pwsh ./DeepBlue.ps1 ./Security.evtx > analysis.txt
    ```
    
3. **Triage findings**:
    
    - Look for repeated failed logons (brute force).
        
    - Look for new accounts created during the game.
        
    - Look for suspicious PowerShell execution.
        
4. **Feed results back** into your defense/offense:
    
    - Block offending IPs in your firewall.
        
    - Hunt for persistence mechanisms.
        
    - Use detections to pivot into Purple Team handoffs.