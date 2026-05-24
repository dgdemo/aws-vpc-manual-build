#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

DB_SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name DBServerSG \
  --description "Security group for database servers" \
  --vpc-id "$VPC_ID" \
  --query 'GroupId' \
  --output text)

save_var "DB_SECURITY_GROUP_ID" "$DB_SECURITY_GROUP_ID"
echo "Created Security Group: $DB_SECURITY_GROUP_ID"    