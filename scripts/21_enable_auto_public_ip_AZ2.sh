#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 modify-subnet-attribute --subnet-id "$PUBLIC_SUBNET_AZ2" --map-public-ip-on-launch "{\"Value\":true}"

echo "Enabled Auto-assign Public IP for Subnet: $PUBLIC_SUBNET_AZ2"