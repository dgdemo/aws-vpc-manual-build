#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

WEB_PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$WEB_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)
save_var "WEB_PUBLIC_IP" "$WEB_PUBLIC_IP"
echo "Web server public IP address: $WEB_PUBLIC_IP"