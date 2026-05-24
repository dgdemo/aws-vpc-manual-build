#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

ELASTIC_IP_ID=$(aws ec2 allocate-address \
  --domain vpc \
  --query 'AllocationId' \
  --output text)

aws ec2 create-tags \
  --resources "$ELASTIC_IP_ID" \
  --tags Key=Name,Value=Public-EIP

save_var "ELASTIC_IP_ID" "$ELASTIC_IP_ID"

echo "Allocated Elastic IP for Public NAT Gateway: $ELASTIC_IP_ID"