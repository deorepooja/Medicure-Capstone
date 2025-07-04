variable "aws_region" {
  default = "us-east-1"
}

variable "aws_zone" {
  default = "us-east-1a"
}

variable "aws_ami" {
  default = "ami-0c2b8ca1dad447f8a" # Ubuntu 22.04 LTS (you can update this)
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  description = "Your AWS EC2 key pair name"
  default     = "medicure-key"
}
