.PHONY: setup env clean

setup:
	@echo "Installing dependencies"
	@sudo apt update -y
	@sudo apt install -y nmap tshark dnsmasq netcat-openbsd netcat-traditional whois curl jq python3-pip 
	@echo "Done"

env:
	@cp -n .env.example .env || true
	@echo "Review and edit .env"
	@echo "run 'python3 -m venv .venv' to create space for python dependencies" 
	@echo "pip3 install flak" 
clean:
	@sudo find /var/forensics -type f -mtime +7 -delete
