#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env


DB_INSTANCE_ID=$(aws ec2 run-instances \
  --image-id "$AMI_ID" \
  --count 1 \
  --instance-type t2.micro \
  --key-name "$KEY_NAME" \
  --security-group-ids "$DB_SECURITY_GROUP_ID" \
  --subnet-id "$PRIVATE_SUBNET_AZ1" \
  --user-data '#!/bin/bash
                yum update -y
                yum install -y mariadb-server
                systemctl start mariadb
                systemctl enable mariadb' \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Manual-DBServer}]' --query 'Instances[0].InstanceId' \
  --output text)

save_var "DB_INSTANCE_ID" "$DB_INSTANCE_ID"
echo "Launched database server instance: $DB_INSTANCE_ID"