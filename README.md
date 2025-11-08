🌍 Terraform Multi-Environment AWS Infrastructure

This project demonstrates a real-time, production-grade Terraform setup for deploying AWS infrastructure (EC2 instances) across multiple environments — Dev, Test, and Prod — using reusable modules, remote backend, and isolated state files.

🧩 Project Overview

This Terraform setup follows a modular and environment-based structure:

Reusable Modules: All core infrastructure logic (e.g., EC2 instance creation) is defined once inside /modules.

Environment Isolation: Each environment (Dev, Test, Prod) has its own backend and variable configuration.

Remote State Management: State files are stored in S3 with DynamoDB used for state locking.

Automation Ready: Supports terraform -chdir for easy automation and CI/CD pipelines.

📂 Folder Structure

terraform-ec2-multi-env/
│
├── README.md
│
├── envs/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── dev.tfvars
│   │
│   ├── test/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── test.tfvars
│   │
│   └── prod/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── prod.tfvars
│
└── modules/
    └── ec2/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

☁️ AWS Resources Created

This setup provisions:

EC2 instances with tagging (Name, Environment, ManagedBy)

(Optional) Future extension — VPC, S3, RDS, etc.

Remote state stored in an S3 bucket

State locking via DynamoDB table

⚙️ Prerequisites

Terraform v1.5+

AWS CLI configured with IAM credentials

S3 bucket for backend (example: company-terraform-states)

DynamoDB table for lock management (example: terraform-lock)

🔐 Backend Configuration

Each environment uses its own backend for isolated state files.

Example: envs/dev/backend.tf

terraform {
  backend "s3" {
    bucket         = "company-terraform-states"
    key            = "ec2/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}


🚀 How to Deploy

Run Terraform directly from the project root using the -chdir flag
(to navigate into the environment folder automatically).

🧱 Initialize Terraform

Dev Environment
terraform -chdir=envs/dev init
terraform -chdir=envs/dev plan
terraform -chdir=envs/dev apply -auto-approve

Test Environment
terraform -chdir=envs/test init
terraform -chdir=envs/test plan 
terraform -chdir=envs/test apply -auto-approve


Prod Environment
terraform -chdir=envs/prod init
terraform -chdir=envs/prod plan
terraform -chdir=envs/prod apply -auto-approve

🧹 Destroy (Clean Up Resources)
Dev
terraform -chdir=envs/dev destroy -auto-approve

🪣 S3 & DynamoDB Setup

Before first terraform init, create backend resources:

aws s3api create-bucket --bucket company-terraform-states --region us-east-1
aws s3api put-bucket-versioning --bucket company-terraform-states --versioning-configuration Status=Enabled
aws dynamodb create-table \
  --table-name terraform-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST

🧰 Useful Commands

| Command                    | Description                         |
| -------------------------- | ----------------------------------- |
| `terraform fmt`            | Format Terraform files              |
| `terraform validate`       | Validate syntax and structure       |
| `terraform output`         | Display module output values        |
| `terraform state list`     | View managed resources              |
| `terraform workspace list` | View Terraform workspaces (if used) |


🤖 Automation Tip (Jenkins / GitHub Actions)

You can use environment variables to deploy automatically per environment:

terraform -chdir=envs/${ENV} init
terraform -chdir=envs/${ENV} plan -var-file=${ENV}.tfvars
terraform -chdir=envs/${ENV} apply -var-file=${ENV}.tfvars -auto-approve


🧱 Future Enhancements

Add VPC, Subnets, and Security Groups modules

Add RDS and S3 provisioning

Integrate with Jenkins pipeline for CI/CD

Add cost optimization tagging and CloudWatch monitoring

👨‍💻 Author

Imran Khan Mohammad
DevOps Engineer | Terraform | AWS | CI/CD | Docker | Kubernetes


