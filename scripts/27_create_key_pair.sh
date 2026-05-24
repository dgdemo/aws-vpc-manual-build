#!/usr/bin/env bash
set -euo pipefail

# lib.sh is a helper script to manage environment variables and other shared functions.
source lib.sh
[ -f session.env ] && source session.env

KEY_NAME="manual-vpc-tutorial-key"


aws ec2 create-key-pair --key-name "$KEY_NAME" --query 'KeyMaterial' --output text > "${KEY_NAME}.pem"
chmod 400 "${KEY_NAME}.pem"
save_var "KEY_NAME" "$KEY_NAME"
echo "Created key pair '$KEY_NAME' and saved private key to '${KEY_NAME}.pem'"

