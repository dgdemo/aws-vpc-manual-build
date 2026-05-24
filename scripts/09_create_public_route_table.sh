#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

PUBLIC_ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id "$VPC_ID" \
  --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=Public-RT}]' \
  --query 'RouteTable.RouteTableId' \
  --output text)

save_var "PUBLIC_ROUTE_TABLE_ID" "$PUBLIC_ROUTE_TABLE_ID"
echo "Created Public Route Table: $PUBLIC_ROUTE_TABLE_ID"