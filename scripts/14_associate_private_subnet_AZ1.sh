#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 associate-route-table --route-table-id "$PRIVATE_ROUTE_TABLE_ID" --subnet-id "$PRIVATE_SUBNET_AZ1"

echo "Associated Private Route Table: $PRIVATE_ROUTE_TABLE_ID with Subnet: $PRIVATE_SUBNET_AZ1"
