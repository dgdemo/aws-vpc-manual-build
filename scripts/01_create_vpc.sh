#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

VPC_ID=$(aws ec2 create-vpc \
 --cidr-block 10.0.0.0/16 \
 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]' \
 --query 'Vpc.VpcId' \
 --output text)
 
save_var "VPC_ID" "$VPC_ID"

echo "Created VPC: $VPC_ID"