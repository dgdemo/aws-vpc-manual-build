#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

WEB_SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name WebServerSG \
  --description "Security group for web servers" \
  --vpc-id "$VPC_ID" \
  --query 'GroupId' \
  --output text)
  
save_var "WEB_SECURITY_GROUP_ID" "$WEB_SECURITY_GROUP_ID"
echo "Created Security Group: $WEB_SECURITY_GROUP_ID"