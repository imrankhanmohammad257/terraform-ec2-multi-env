terraform {
  required_version = ">= 1.5.0"
}

module "ec2_instance" {
  source        = "../../modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  environment   = var.environment
  key_name      = var.key_name
  name          = var.name
}
