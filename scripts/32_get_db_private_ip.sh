#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

# Get the private IP of the database server
DB_PRIVATE_IP=$(aws ec2 describe-instances \
  --instance-ids "$DB_INSTANCE_ID" \
  --query 'Reservations[0].Instances[0].PrivateIpAddress' \
  --output text)

save_var "DB_PRIVATE_IP" "$DB_PRIVATE_IP"
echo "Database server private IP address: $DB_PRIVATE_IP"