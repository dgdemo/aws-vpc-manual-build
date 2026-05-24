#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 create-route --route-table-id "$PRIVATE_ROUTE_TABLE_ID" --destination-cidr-block 0.0.0.0/0 --nat-gateway-id "$NAT_GATEWAY_ID"
echo "Created default route in Private Route Table: $PRIVATE_ROUTE_TABLE_ID to NAT Gateway: $NAT_GATEWAY_ID"
