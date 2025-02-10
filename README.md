# Terraform AWS Infrastructure

## 📌 Overview
This Terraform setup provisions:
- A VPC with public/private subnets
- NAT Gateway for private subnet internet access
- Security Groups for EC2 instances
- Remote state storage in S3

## 🚀 Deployment Steps
1. Initialize Terraform:
   ```sh
   terraform init
Plan changes:
sh
Copy
Edit
terraform plan
Apply infrastructure:
sh
Copy
Edit
terraform apply -auto-approve
Destroy when done:
sh
Copy
Edit
terraform destroy -auto-approve
