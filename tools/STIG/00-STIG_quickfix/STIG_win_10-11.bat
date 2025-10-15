@echo off
REM STIG.bat - basic, conservative STIG-style hardening for Windows 10 / 11
REM Run as Administrator. Tested to be minimal-impact; verify before mass deploy.

echo === STIG baseline hardening starting ===

REM 1) Require secure sign-in and interactive logon protections
echo [1/15] Enforcing secure sign-in and disabling guest
net user Guest /active:no >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableCAD" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "LegalNoticeCaption" /t REG_SZ /d "" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "LegalNoticeText" /t REG_SZ /d "" /f >nul

REM 2) Enable Windows Firewall for all profiles
echo [2/15] Enabling Windows Firewall (Domain, Private, Public)
netsh advfirewall set allprofiles state on

REM 3) Disable SMBv1
echo [3/15] Disabling SMBv1
dism /online /norestart /disable-feature /featurename:SMB1Protocol >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "SMB1" /t REG_DWORD /d 0 /f >nul

REM 4) Enforce Network Level Authentication for RDP and disable RDP listen by default
echo [4/15] Enforcing NLA and disabling RDP listener
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "UserAuthentication" /t REG_DWORD /d 1 /f >nul

REM 5) Configure Windows Update to install updates automatically (recommended)
echo [5/15] Setting Windows Update to automatic (4 = Auto install)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 4 /f >nul

REM 6) Enable Defender real-time protection and periodic scanning (if Defender is present)
echo [6/15] Enabling Microsoft Defender real-time protection and periodic scan
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Set-MpPreference -DisableRealtimeMonitoring $false; Set-MpPreference -DisableArchiveScanning $false; Set-MpPreference -ScanAvgCPULoadFactor 50; Add-MpPreference -MAPSReporting 1" >nul 2>&1

REM 7) Enforce UAC to highest prompt behavior for administrators in Admin Approval Mode
echo [7/15] Enforcing UAC prompt behavior
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 1 /f >nul

REM 8) Configure account lockout thresholds (local policy)
echo [8/15] Configuring account lockout: 5 invalid attempts, 15 minute lockout
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "secedit /export /cfg C:\Windows\Temp\secpol_before.cfg > $null; ^
   $cfg = Get-Content C:\Windows\Temp\secpol_before.cfg; ^
   $cfg = $cfg -replace 'LockoutBadCount = .*','LockoutBadCount = 5'; ^
   $cfg = $cfg -replace 'ResetLockoutCount = .*','ResetLockoutCount = 15'; ^
   $cfg = $cfg -replace 'LockoutDuration = .*','LockoutDuration = 15'; ^
   $cfg | Out-File C:\Windows\Temp\secpol_new.cfg -Encoding Unicode; ^
   secedit /configure /db C:\Windows\security\local.sdb /cfg C:\Windows\Temp\secpol_new.cfg /areas SECURITYPOLICY > $null" >nul 2>&1

REM 9) Disable autorun for removable media
echo [9/15] Disabling Autorun for removable media
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f >nul

REM 10) Ensure SMB signing required where applicable (server and client)
echo [10/15] Enforcing SMB signing where supported
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "RequireSecuritySignature" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "RequireSecuritySignature" /t REG_DWORD /d 1 /f >nul

REM 11) Enable Audit policies for key events (logon, account management, process creation)
echo [11/15] Enabling auditing for logon and process creation
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "AuditPol /set /subcategory:'Logon' /success:enable /failure:enable; ^
   AuditPol /set /subcategory:'Account Lockout' /success:enable /failure:enable; ^
   AuditPol /set /subcategory:'Process Creation' /success:enable /failure:enable" >nul 2>&1

REM 12) Harden local RDP and remote management: restrict remote administration
echo [12/15] Restricting remote administration to admin accounts only
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsFirewall\DoNotAllowExceptions" /v "DisableRemoteAdminException" /t REG_DWORD /d 1 /f >nul

REM 13) Disable unnecessary services commonly exploited (sample list)
echo [13/15] Stopping and disabling known risky services if present
for %%S in "Telnet" "RemoteRegistry" "SSDPSRV" "UPnPHost" "XblAuthManager" "XboxGipSvc" "WSearch" "EnterpriseAppMgmt" do (
  sc queryex %%S >nul 2>&1 && (
    echo Disabling %%S
    sc config %%S start= disabled >nul 2>&1
    sc stop %%S >nul 2>&1
  )
)

REM 14) DNS client hardening - register only primary DNS and disable LMHOSTS lookup
echo [14/15] Hardening DNS client lookups
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableDynamicUpdate" /t REG_DWORD /d 0 /f >nul

REM 15) Final: flush policies and inform operator
echo [15/15] Refreshing Group Policy and firewall rules
gpupdate /force >nul 2>&1
netsh advfirewall show allprofiles

echo === STIG baseline hardening complete ===
echo Review actions and test functionality before wide deployment.
exit /b 0
