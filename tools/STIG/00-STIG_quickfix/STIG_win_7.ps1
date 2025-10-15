# Enforce password policy
secedit /export /cfg C:\temp\secpol.cfg
(gc C:\temp\secpol.cfg) -replace "MinimumPasswordLength = .*","MinimumPasswordLength = 14" |
    Out-File C:\temp\secpol.cfg
secedit /configure /db secedit.sdb /cfg C:\temp\secpol.cfg /areas SECURITYPOLICY

# Enable auditing
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
auditpol /set /category:"Account Logon" /success:enable /failure:enable
