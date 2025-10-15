# windows_triage.ps1
$Out="C:\Temp\pvj_triage_$(Get-Date -Format s)"
New-Item -Path $Out -ItemType Directory -Force | Out-Null
Get-Process | Out-File "$Out\processes.txt"
Get-NetTCPConnection | Out-File "$Out\netconns.txt"
schtasks /query /fo LIST | Out-File "$Out\tasks.txt"
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "$Out\runkeys.reg" /y
Compress-Archive -Path $Out -DestinationPath "${Out}.zip"
Write-Output "${Out}.zip"
