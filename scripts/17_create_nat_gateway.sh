#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

NAT_GATEWAY_ID=$(aws ec2 create-nat-gateway \
  --subnet-id "$PUBLIC_SUBNET_AZ1" \
  --allocation-id "$ELASTIC_IP_ID" \
  --tag-specifications 'ResourceType=natgateway,Tags=[{Key=Name,Value=Manual-NAT-Gateway}]' \
  --query 'NatGateway.NatGatewayId' \
  --output text)

save_var "NAT_GATEWAY_ID" "$NAT_GATEWAY_ID"

echo "Created NAT Gateway: $NAT_GATEWAY_ID"