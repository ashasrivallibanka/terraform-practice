#                 TERRAFORM PROJECT 7
#                AWS Infrastructure

# Objective

Provision basic AWS infrastructure using Terraform and understand how Terraform manages real cloud resources.

---

# What I Created

Using Terraform, I created:

```text
VPC
↓
Public Subnet
↓
Internet Gateway
↓
Route Table
↓
Security Group
↓
EC2 Instance
```

---

# AWS Provider

Terraform uses the AWS Provider to communicate with AWS APIs.

```hcl
provider "aws" {
  region = var.aws_region
}
```

I used:

```text
Region: ap-south-1
```

Terraform used the AWS CLI credentials configured in WSL.

I did not hardcode AWS access keys inside Terraform files.

---

# VPC

Created a custom VPC.

```text
CIDR: 10.0.0.0/16
```

VPC provides an isolated network for my AWS resources.

---

# Public Subnet

Created a public subnet inside the VPC.

```text
CIDR: 10.0.1.0/24
```

The subnet belongs to the VPC using:

```hcl
vpc_id = aws_vpc.main.id
```

This also creates an implicit dependency.

---

# Internet Gateway

Created an Internet Gateway and attached it to the VPC.

Purpose:

```text
VPC
↓
Internet Gateway
↓
Internet
```

It allows resources in the public subnet to communicate with the internet when routing is configured.

---

# Route Table

Created a public route table with:

```text
0.0.0.0/0
```

pointing to the Internet Gateway.

Then associated the route table with the public subnet.

---

# Security Group

Created a Security Group for the EC2 instance.

Allowed:

```text
Port 22 → SSH
Port 80 → HTTP
```

For learning, SSH was allowed broadly.

In production, SSH should be restricted to trusted IPs, VPN, bastion host, or AWS Systems Manager.

---

# Data Source

Used a data source to get an existing Amazon Linux AMI instead of hardcoding the AMI ID.

```hcl
data "aws_ami" "amazon_linux" {
}
```

Remember:

```text
Resource    → Creates/manages something
Data Source → Reads existing information
```

---

# EC2 Instance

Created an EC2 instance using Terraform.

Used:

```text
AMI          → From data source
Instance Type → From variable
Subnet        → Public subnet
Security Group → Web security group
```

Terraform automatically understood the dependencies between these resources.

---

# user_data

Used `user_data` to configure the EC2 instance automatically during startup.

It installed Nginx and started the web server.

Flow:

```text
EC2 Starts
↓
user_data Executes
↓
Nginx Installed
↓
Website Available
```

---

# Variables

Used variables for reusable values such as:

```text
AWS Region
Project Name
VPC CIDR
Subnet CIDR
Instance Type
```

This avoided hardcoding values throughout the configuration.

---

# Outputs

Used outputs to display useful values after deployment.

Examples:

```text
VPC ID
Subnet ID
EC2 Instance ID
EC2 Public IP
Website URL
```

Command:

```bash
terraform output
```

---

# Terraform Workflow Used

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform state list
terraform destroy
```

Flow:

```text
Write Terraform Code
↓
terraform init
↓
terraform plan
↓
Review Changes
↓
terraform apply
↓
AWS Resources Created
↓
terraform destroy
↓
AWS Resources Removed
```

---

# Terraform State

Terraform tracked the AWS resources in:

```text
terraform.tfstate
```

Example resources:

```text
aws_vpc.main
aws_subnet.public
aws_internet_gateway.main
aws_route_table.public
aws_security_group.web
aws_instance.web
```

Command:

```bash
terraform state list
```

---

# Important Security Point

AWS credentials were configured using:

```bash
aws configure
```

and stored outside the Terraform code.

I did not put:

```text
AWS Access Key
AWS Secret Key
```

inside `.tf` files.

Terraform state and sensitive `.tfvars` files should also not be pushed to GitHub.

---

# Quick Interview Revision

**What did I create using Terraform?**  
I provisioned a VPC, public subnet, Internet Gateway, route table, Security Group, and EC2 instance on AWS.

**How did Terraform connect to AWS?**  
Using the AWS Provider and credentials configured through the AWS CLI.

**Why did I use variables?**  
To avoid hardcoding and make the Terraform configuration reusable.

**Why did I use a data source?**  
To fetch an existing AMI dynamically instead of hardcoding the AMI ID.

**How did the EC2 instance get internet access?**

```text
EC2
↓
Public Subnet
↓
Route Table
↓
Internet Gateway
↓
Internet
```

**How did Terraform know the creation order?**  
Terraform created a dependency graph based on resource references.

**What is the purpose of `terraform plan`?**  
To preview the resources Terraform will create, modify, or destroy.

**What is the purpose of `terraform apply`?**  
To actually execute those infrastructure changes.

**What does Terraform state do?**  
It tracks the relationship between Terraform resources and actual AWS infrastructure.

**Why run `terraform destroy` after the lab?**  
To remove the AWS resources created by Terraform and avoid unnecessary cloud charges.

---

# My Project Summary

I used Terraform to provision a basic AWS network and EC2 infrastructure. I created the VPC, subnet, Internet Gateway, route table, Security Group, and EC2 instance using Terraform instead of creating them manually from the AWS Console. I used variables for reusable configuration, a data source for the AMI, outputs for important resource information, and Terraform state to track the infrastructure. I also used `user_data` to install Nginx automatically on the EC2 instance and finally destroyed the infrastructure using Terraform after testing.
