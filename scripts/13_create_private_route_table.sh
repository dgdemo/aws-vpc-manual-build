#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

PRIVATE_ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id "$VPC_ID" \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=Private-RT}]' \
  --query 'RouteTable.RouteTableId' \
  --output text)
save_var "PRIVATE_ROUTE_TABLE_ID" "$PRIVATE_ROUTE_TABLE_ID"
echo "Created Private Route Table: $PRIVATE_ROUTE_TABLE_ID"
