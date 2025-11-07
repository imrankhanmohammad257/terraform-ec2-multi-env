resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name        = "${var.environment}-ec2"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
