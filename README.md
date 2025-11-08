# 🌍 Terraform Multi-Environment AWS Infrastructure

This project demonstrates a **real-time, production-grade Terraform setup** for deploying AWS infrastructure (EC2 instances) across multiple environments — **Dev**, **Test**, and **Prod** — using reusable modules, remote backend, and isolated state files.

---

## 🧩 Project Overview

This Terraform setup follows a **modular and environment-based structure**:
- 🔁 **Reusable Modules** — Infrastructure logic is defined once inside `/modules`
- 🧱 **Environment Isolation** — Each environment (Dev/Test/Prod) has its own backend and variable configuration
- ☁️ **Remote State Management** — Terraform state stored in S3 and locked with DynamoDB
- ⚙️ **Automation Ready** — Supports `terraform -chdir` for multi-environment CI/CD pipelines


## 📂 Folder Structure

```
terraform-ec2-multi-env/
│
├── README.md
│
├── envs/
│ ├── dev/
│ │ ├── backend.tf
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── dev.tfvars
│ │
│ ├── test/
│ │ ├── backend.tf
│ │ ├── main.tf
│ │ ├── variables.tf
│ │ └── test.tfvars
│ │
│ └── prod/
│ ├── backend.tf
│ ├── main.tf
│ ├── variables.tf
│ └── prod.tfvars
│
└── modules/
└── ec2/
├── main.tf
├── variables.tf
└── outputs.tf



## ☁️ AWS Resources Created

- 🖥️ EC2 instances with tagging (`Name`, `Environment`, `ManagedBy`)
- 🪣 Remote backend stored in **S3**
- 🔒 State locking handled via **DynamoDB**
- 🧩 Ready for CI/CD integration with Jenkins or GitHub Actions

---

## ⚙️ Prerequisites

- Terraform v1.5+  
- AWS CLI configured with credentials  
- S3 bucket for remote backend  
- DynamoDB table for state locking  

---

## 🔐 Backend Configuration Example

**envs/dev/backend.tf**
```hcl
terraform {
  backend "s3" {
    bucket         = "company-terraform-states"
    key            = "ec2/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}


🚀 Deployment Commands

You can run Terraform from the project root using the -chdir flag (no need to cd into folders).

🧱 Initialize Terraform

Dev Environment
terraform -chdir=envs/dev init
terraform -chdir=envs/dev plan 
terraform -chdir=envs/dev apply -auto-approve

🧹 Destroy Infrastructure (Cleanup)

Dev
terraform -chdir=envs/dev destroy -auto-approve

🪣 Backend Setup (One Time)

Before first terraform init, create the backend S3 bucket and DynamoDB table:

aws s3api create-bucket --bucket company-terraform-states --region us-east-1
aws s3api put-bucket-versioning --bucket company-terraform-states --versioning-configuration Status=Enabled

aws dynamodb create-table \
  --table-name terraform-lock \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST


🧰 Useful Terraform Commands

| Command                    | Description                   |
| -------------------------- | ----------------------------- |
| `terraform fmt`            | Format Terraform files        |
| `terraform validate`       | Validate syntax and structure |
| `terraform output`         | Show output variables         |
| `terraform state list`     | List managed resources        |
| `terraform workspace list` | Show all workspaces           |


🤖 Automation with CI/CD (Optional)

You can automate environment deployments in Jenkins, GitHub Actions, or GitLab:
terraform -chdir=envs/${ENV} init
terraform -chdir=envs/${ENV} plan -var-file=${ENV}.tfvars
terraform -chdir=envs/${ENV} apply -var-file=${ENV}.tfvars -auto-approve

Where ${ENV} = dev, test, or prod.

👨‍💻 Author

Imran Khan Mohammad
🧠 DevOps Engineer | AWS | Terraform | Jenkins | Docker | Kubernetes
📫 Connect with me:
https://www.linkedin.com/in/imrankhanmohammad/


