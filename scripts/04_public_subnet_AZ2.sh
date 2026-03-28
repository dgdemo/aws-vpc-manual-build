#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

PUBLIC_SUBNET_AZ2=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block 10.0.1.0/24 \
  --availability-zone us-east-1b \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Public-Subnet-AZ2}]' \
  --query 'Subnet.SubnetId' \
  --output text)

save_var "PUBLIC_SUBNET_AZ2" "$PUBLIC_SUBNET_AZ2"

echo "Created Public Subnet (AZ2): $PUBLIC_SUBNET_AZ2"