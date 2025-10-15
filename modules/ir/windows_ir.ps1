$ts = Get-Date -Format "yyyyMMddTHHmmssZ"
Write-Output "== Processes =="
Get-Process | Sort CPU -Descending | Select -First 20
Write-Output "== Failed Logons =="
Get-WinEvent -LogName Security -MaxEvents 200 | Where-Object {$_.Id -eq 4625}
Write-Output "== Established Connections =="
Get-NetTCPConnection | Where-Object {$_.State -eq "Established"}
