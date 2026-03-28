#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

echo "Enabling DNS support and hostnames for VPC: $VPC_ID"

aws ec2 modify-vpc-attribute \
--vpc-id $VPC_ID \
--enable-dns-support

aws ec2 modify-vpc-attribute \
--vpc-id $VPC_ID \
--enable-dns-hostnames

echo "DNS support and hostnames enabled for VPC: $VPC_ID"