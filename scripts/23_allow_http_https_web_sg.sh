#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

# Restrict inbound web traffic to the current public IP of this machine
# instead of allowing traffic from anywhere (0.0.0.0/0). This is a more secure practice for testing and development environments.
MY_IP=$(curl -s ifconfig.me | tr -d '\n')

aws ec2 authorize-security-group-ingress --group-id "$WEB_SECURITY_GROUP_ID" --protocol tcp --port 80 --cidr "$MY_IP/32"
aws ec2 authorize-security-group-ingress --group-id "$WEB_SECURITY_GROUP_ID" --protocol tcp --port 443 --cidr "$MY_IP/32"

echo "Allowed HTTP (80) and HTTPS (443) ingress traffic from $MY_IP to Security Group: $WEB_SECURITY_GROUP_ID"