#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

aws ec2 authorize-security-group-ingress --group-id "$DB_SECURITY_GROUP_ID" --protocol tcp --port 3306 --source-group "$WEB_SECURITY_GROUP_ID"
echo "Allowed MySQL (3306) ingress traffic from Web Security Group to Database Security Group"