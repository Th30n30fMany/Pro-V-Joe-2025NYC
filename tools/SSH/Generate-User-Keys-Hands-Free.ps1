#.DESCRIPTION
# Demos how to generate SSH user public/private key pairs non-interactively, i.e., hands-free.
# Similar commands might be added to a user's logon script.
#
#.NOTES
# Requires PowerShell Core (pwsh.exe) or Windows PowerShell Console (powershell.exe)
# In PowerShell, "`n" below is like hitting the Enter key for a CrLf.
exit


# Generate a new Ed25519 key pair with a blank passphrase:
"`n" | ssh-keygen.exe -N "" -q -t ed25519


# Generate new key pair silently, with no status output displayed:
"`n" | ssh-keygen.exe -N "" -q -t ed25519 > $null


# If the key pair already exists, delete the key files first:
Remove-Item -Path ~\.ssh\id_ed25519*
"`n" | ssh-keygen.exe -N "" -q -t ed25519 > $null 


# Only generate a new key pair if the pair does not currently exist:
if (-not (Test-Path -Path ~\.ssh\id_ed25519)) 
    {  "`n" | ssh-keygen.exe -N "" -q -t ed25519 > $null }



