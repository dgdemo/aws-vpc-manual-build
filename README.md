# AWS VPC Manual Build with CLI - Part 1 of 3
## Next: AWS VPC with Infrastructure as Code (Terraform)

This is a demonstration of creating a Virtual Private Cloud (VPC) using the AWS Command Line Interface (AWS CLI). You'll learn how to set up a VPC with public and private subnets, configure internet connectivity, and deploy EC2 instances to demonstrate a common web application architecture. This project is part of a series of demos where we will progress from:

1 - Manual build using CLI

2 - Infrastructure as Code using Terraform

3 - Adding security and policy-as-code into the build process

While the main purpose of this 3 part series is to demonstrate a progression from manual to automated and more secure build processes, it is intentionally kept minimal and serves as a deliberate return to AWS fundamentals for anyone who wants to learn or validate their understanding of basic AWS infrastructure components and dependencies.

The original steps were taken from AWS documentation at:
https://docs.aws.amazon.com/vpc/latest/userguide/getting-started-with-amazon-vpc-using-the-aws-cli.html

Enhancements include exporting resource values to environment variables for easier tracking, and adding security group rules (not included in the original AWS walkthrough) to allow SSH access restricted to your local IP.

What This Project Builds
A basic public web tier + private database tier architecture:

* One VPC with CIDR 10.0.0.0/16
* Two public subnets, one in each AZ
* Two private subnets, one in each AZ
* One Internet Gateway attached to the VPC
* One public route table associated to both public subnets, with default route to the IGW
* One private route table associated to both private subnets, with default route to a single NAT Gateway
* One NAT Gateway placed in only one public subnet
* One web EC2 instance in a public subnet
* One DB EC2 instance with MariaDB in a private subnet

## Session State Handling

To make the CLI workflow restartable and easier to follow, resource IDs are persisted to a local session.env file. This allows the demo to recover from interruptions (e.g., closed terminals) and reflects a more production-friendly scripting approach.

## Reporting
A script (infrastructure_report.sh) is provided to report all relevant resources in your AWS account. While it highlights what is created in this exercise, it will also surface any other existing resources so you have a complete view of what is currently running. This is especially useful for identifying forgotten or unintended resources that could incur charges.

If you're working in a personal or shared AWS account, it’s strongly recommended to configure billing alerts and budgets:
https://docs.aws.amazon.com/cost-management/latest/userguide/budgets-managing-costs.html

## Architecture
- Compute (EC2s) in green rounded boxes.
- Network gateways (IGW, NAT) in blue pill shapes.
- Routing logic (route tables) in yellow rectangles.

```mermaid
flowchart LR

    %% Nodes
    Internet((Internet))

    subgraph VPC["VPC 10.0.0.0/16"]

        IGW(("Internet Gateway"))
        PubRT["Public Route Table<br/>0.0.0.0/0 → IGW"]
        PrivRT["Private Route Table<br/>0.0.0.0/0 → NAT Gateway"]

        subgraph AZ1["Availability Zone 1"]

            %% Public subnet with Web Server and NAT
            subgraph Pub1["Public Subnet (10.0.1.0/24)"]
                Web(["Web Server EC2<br/>Public IP / SSH Accessible"])
                NAT(("NAT Gateway<br/>(Elastic IP)"))
            end

            %% Private subnet with DB
            subgraph Priv1["Private Subnet (10.0.2.0/24)"]
                DB(["DB EC2<br/>Private IP<br/>SSH via Web Server"])
            end
        end
    end

    %% Routing relationships
    Internet -->|"Inbound SSH (22), HTTP/HTTPS"| IGW
    IGW -->|"0.0.0.0/0"| PubRT
    PubRT -->|Routes| Pub1
    PrivRT -->|Routes| Priv1
    PrivRT -->|"Default Route → NAT"| NAT
    NAT -->|"Outbound via IGW"| IGW

    %% SSH and application flows
    Internet -. "SSH (22)" .-> Web
    Web -. "SSH -A (22)" .-> DB
    Priv1 -. "Outbound only via NAT" .-> NAT

    %% Styles: color and shape coding
    style Internet fill:#e0e0e0,stroke:#333,stroke-width:1px
    style IGW fill:#b3cde0,stroke:#03396c,stroke-width:2px
    style NAT fill:#b3cde0,stroke:#03396c,stroke-width:2px
    style PubRT fill:#fff2cc,stroke:#ffb300,stroke-width:2px
    style PrivRT fill:#fff2cc,stroke:#ffb300,stroke-width:2px
    style Web fill:#d5f5e3,stroke:#196f3d,stroke-width:2px
    style DB fill:#d5f5e3,stroke:#196f3d,stroke-width:2px
    style VPC fill:#fafafa,stroke:#888,stroke-width:1px
    style Pub1 fill:#f0f8ff,stroke:#999,stroke-width:1px
    style Priv1 fill:#f0f8ff,stroke:#999,stroke-width:1px
```

## Production Considerations

For production environments, consider the following security and architecture best practices:

* NAT Gateway Design: This demo uses a single NAT Gateway in one AZ for simplicity and cost. In production, deploy one NAT Gateway per AZ to avoid cross-AZ traffic dependencies and single points of failure.

* Network ACLs: Implement Network ACLs as an additional layer of security beyond security groups.

* VPC Flow Logs: Enable VPC Flow Logs to monitor and analyze network traffic patterns.

* Resource Tagging: Implement a comprehensive tagging strategy for better resource management.

## List of AWS CLI Commands Used in This Project
Even a basic VPC setup requires ~40 discrete API operations. This is where Infrastructure as Code helps reduce complexity, enforce consistency, and prevent configuration drift. Be sure to check out demo 2 - AWS Basic Infrastructure with Terraform.

- aws configure list
- aws sts get-caller-identity
- aws ec2 create-vpc
- aws ec2 modify-vpc-attribute
- aws ec2 describe-availability-zones
- aws ec2 create-subnet
- aws ec2 create-internet-gateway
- aws ec2 attach-internet-gateway
- aws ec2 create-route-table
- aws ec2 create-route
- aws ec2 associate-route-table
- aws ec2 allocate-address
- aws ec2 create-nat-gateway
- aws ec2 wait nat-gateway-available
- aws ec2 modify-subnet-attribute
- aws ec2 create-security-group
- aws ec2 authorize-security-group-ingress
- aws ec2 describe-vpcs
- aws ec2 describe-subnets
- aws ec2 describe-route-tables
- aws ec2 describe-internet-gateways
- aws ec2 describe-nat-gateways
- aws ec2 describe-security-groups
- aws ec2 create-key-pair
- aws ec2 describe-images
- aws ec2 run-instances
- aws ec2 describe-instances
- aws ec2 terminate-instances
- aws ec2 wait instance-terminated
- aws ec2 delete-key-pair
- aws ec2 delete-nat-gateway
- aws ec2 wait nat-gateway-deleted
- aws ec2 release-address
- aws ec2 delete-security-group
- aws ec2 disassociate-route-table
- aws ec2 delete-route-table
- aws ec2 detach-internet-gateway
- aws ec2 delete-internet-gateway
- aws ec2 delete-subnet
- aws ec2 delete-vpc
