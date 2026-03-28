#!/bin/bash
set -eou pipefail

aws ec2 describe-vpcs \
   --query "Vpcs[*].{VpcId:VpcId, Name:Tags[?Key=='Name'].Value|[0], CidrBlock:CidrBlock}" \
   --output table

aws ec2 describe-subnets \
   --query "Subnets[*].{SubnetId:SubnetId, Name:Tags[?Key=='Name'].Value|[0], CidrBlock:CidrBlock}" \
   --output table

aws ec2 describe-route-tables \
   --query "RouteTables[*].{RouteTableId:RouteTableId, Name:Tags[?Key=='Name'].Value|[0]}" \
   --output table

aws ec2 describe-internet-gateways \
   --query "InternetGateways[*].{InternetGatewayId:InternetGatewayId, Name:Tags[?Key=='Name'].Value|[0]}" \
   --output table

aws ec2 describe-nat-gateways \
   --query "NatGateways[*].{NatGatewayId:NatGatewayId, Name:Tags[?Key=='Name'].Value|[0]}" \
   --output table

aws ec2 describe-security-groups \
   --query "SecurityGroups[*].{GroupId:GroupId, Name:GroupName}" \
   --output table