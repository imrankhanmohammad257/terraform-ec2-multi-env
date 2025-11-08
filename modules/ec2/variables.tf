variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "key_name" {
  description = "SSH key to access EC2"
  type        = string
}

variable "name" {
  description = "Name of the EC2 instance"
  type        = string
}
