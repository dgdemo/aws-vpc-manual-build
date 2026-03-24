# AWS VPC Manual Build with CLI - Part 1 of 3
Next up: Infrastructure as Code (Terraform)

This is a demonstration of creating a Virtual Private Cloud (VPC) using the AWS Command Line Interface (AWS CLI). You'll learn how to set up a VPC with public and private subnets, configure internet connectivity, and deploy EC2 instances to demonstrate a common web application architecture. This project is part of a series of demos where we will progress from:

1 - manual build using CLI

2 - Infrastructure as Code using Terraform

3 - Adding security and policy-as-code into the build process

While the main purpose of this 3 part series is to demonstrate a progression from manual to automated and more secure build processes, it is also kept minimal and serves as a deliberate return to AWS fundamentals for anyone who wants to learn or validate their understanding of basic AWS infrastructure components and dependencies.

The original steps were taken from AWS documentation at:
https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html

A few enhancements have been added here to include things like exporting resource values to environment variables for easy tracking and additional security group rules that were left out of the original AWS walkthrough to allow SSH functionality and using your local development environment's IP to ensure that access to resources is restricted.

## Architecture

```mermaid
flowchart TD
    Internet[Internet] --> IGW[Internet Gateway]

    subgraph VPC[VPC]
        PublicSubnet[Public Subnet]
        PrivateSubnet[Private Subnet]

        WebEC2[Web Server EC2]
        NAT[NAT Gateway]
        DBEC2["DB EC2 (MariaDB)"]

        IGW --> PublicSubnet
        PublicSubnet --> WebEC2
        PublicSubnet --> NAT

        PrivateSubnet --> DBEC2

        %% outbound internet access for private instances
        PrivateSubnet -. outbound via NAT .-> NAT

        %% SSH access paths
        Internet -. SSH .-> WebEC2
        WebEC2 -. SSH .-> DBEC2
    end
    ```