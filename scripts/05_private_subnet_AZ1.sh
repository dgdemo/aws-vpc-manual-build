#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

PRIVATE_SUBNET_AZ1=$(aws ec2 create-subnet \
  --vpc-id "$VPC_ID" \
  --cidr-block 10.0.2.0/24 \
  --availability-zone us-east-1a \
  --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=Private-Subnet-AZ1}]' \
  --query 'Subnet.SubnetId' \
  --output text)

 save_var "PRIVATE_SUBNET_AZ1" "$PRIVATE_SUBNET_AZ1"
 
 echo "Created Private Subnet (AZ1): $PRIVATE_SUBNET_AZ1"
 



