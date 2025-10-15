# Token Placement Map (10 canonical host templates)

1) Windows workstation
 - Public file with token link
 - ProgramData fake API key

2) Linux webserver
 - Hidden admin HTML with HTTP token
 - /opt configs with fake DB string

3) File server
 - Share with archived credential zip containing token file

Placement guidance:
- 1-3 tokens per host class
- Higher density on critical hosts
- Rotate tokens between rounds

# Token Placement Map
Linux:
- /home/<user>/.config/.cache/.sync/.id_rsa.pub
- /opt/.assets/.archive/.flag_<uuid>.tmp
Windows:
- C:\Users\<user>\AppData\Local\.cache\.flag_<uuid>.tmp
- C:\ProgramData\.assets\.doc_<uuid>.lnk
Types: HTTP/DNS beacons, fake creds, subtle flags
Expected hits: file open, web fetch, DNS resolve, cred use
