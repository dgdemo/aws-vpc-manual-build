# AWS VPC Manual Build with CLI - Part 1 of 3

This is a demonstration of creating a Virtual Private Cloud (VPC) using the AWS Command Line Interface (AWS CLI). You'll learn how to set up a VPC with public and private subnets, configure internet connectivity, and deploy EC2 instances to demonstrate a common web application architecture. This project is part of a series of demos where we will progress from:
1 - manual build using CLI
2 - Infrastructure as Code using Terraform
3 - Adding security and policy-as-code into the build proecess

The original steps were taken from AWS documentation at:
https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html

A few enhancements have been added here to include things like exporting resource values to environment variables for easy tracking and additional security group rules that were left out of the AWS documentation to allow SSH functionality and using local development environment's IP to ensure access to created resources are not open to the world.

## Architecture (draft)
* VPC
* public subnet (web server)
* private subnet (DB)
* IGW / routing
* SSH path (important)
