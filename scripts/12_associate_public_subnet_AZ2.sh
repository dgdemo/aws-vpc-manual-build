#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 associate-route-table --route-table-id "$PUBLIC_ROUTE_TABLE_ID" --subnet-id "$PUBLIC_SUBNET_AZ2"

echo "Associated Public Route Table: $PUBLIC_ROUTE_TABLE_ID with Subnet: $PUBLIC_SUBNET_AZ2"