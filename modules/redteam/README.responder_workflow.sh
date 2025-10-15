# Consider adding -d to disable SMB signing requirement (may miss some creds)
# Consider adding -A to poison Auth (NTLMv1) if needed
# Consider adding -F to log fingerprints of hosts that query us
# Consider adding -D to log SMBv1 requests (may be noisy)
# Consider adding -P to log NTLMv1 hashes (may be noisy)
# Consider adding -N to disable WPAD (may miss some creds)
# Consider adding -m to enable SMB signing (may miss some creds)
# Consider adding -i to ignore certain hosts (e.g. DC)