# If you need a quick and dirty netcat in Windows without 
# installing anything, you can fire up a listener socket 
# natively, log it to a file, etc.  Example below is for a 
# simple syslog test - put your local IP as the syslog 
# destination on whatever you want to log and run this:

$port = 514
$logfile = "C:\Temp\syslog_capture.log"
$logdir = Split-Path $logfile
if (!(Test-Path $logdir)) { New-Item -ItemType Directory -Path $logdir | Out-Null }

$udp = New-Object System.Net.Sockets.UdpClient($port)
Write-Host "Listening on UDP port $port... Logging to $logfile"
while ($true)
{
$remote = New-Object System.Net.IPEndPoint([System.Net.IPAddress]::Any, 0)
$bytes = $udp.Receive([ref]$remote)
$message = [System.Text.Encoding]::UTF8.GetString($bytes)
$line = "[$($remote.Address):$($remote.Port)] $message"
Write-Host $line
Add-Content -Path $logfile -Value $line
}