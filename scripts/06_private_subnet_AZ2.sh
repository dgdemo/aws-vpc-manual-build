#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

PRIVATE_SUBNET_AZ2=$(aws ec2 create-subnet \
  --vpc-id "$VPC_ID" \
  --cidr-block 10.0.3.0/24 \
  --availability-zone us-east-1b \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Private-Subnet-AZ2}]' \
  --query 'Subnet.SubnetId' \
  --output text)

 save_var "PRIVATE_SUBNET_AZ2" "$PRIVATE_SUBNET_AZ2"
 
 echo "Created Private Subnet (AZ2): $PRIVATE_SUBNET_AZ2"