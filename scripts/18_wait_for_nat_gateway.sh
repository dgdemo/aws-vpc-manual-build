#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 wait nat-gateway-available --nat-gateway-ids "$NAT_GATEWAY_ID"
echo "NAT Gateway: $NAT_GATEWAY_ID is now available."