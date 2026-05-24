#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 create-route --route-table-id "$PUBLIC_ROUTE_TABLE_ID" --destination-cidr-block 0.0.0.0/0 --gateway-id "$INTERNET_GATEWAY_ID"

echo "Created default route in Public Route Table: $PUBLIC_ROUTE_TABLE_ID to Internet Gateway: $INTERNET_GATEWAY_ID"