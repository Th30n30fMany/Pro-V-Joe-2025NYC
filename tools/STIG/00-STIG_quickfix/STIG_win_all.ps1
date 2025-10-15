# stig_windows.ps1
Start-Transcript -Path "C:\Logs\stig_windows_$(Get-Date -Format yyyyMMddTHHmmss).log"

# Password policy
net accounts /minpwlen:14 /maxpwage:60 /lockoutthreshold:5

# Audit policy
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
auditpol /set /category:"Account Logon" /success:enable /failure:enable

# Disable SMBv1 (Server 2016/2019)
Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force

# Enable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

Stop-Transcript
