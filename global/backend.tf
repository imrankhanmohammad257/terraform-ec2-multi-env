terraform {
  backend "s3" {
    bucket         = "company-terraform-states"
    key            = "ec2/${var.environment}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
