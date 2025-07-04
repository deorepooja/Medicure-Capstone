provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "medicure_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Medicure-VPC"
  }
}

resource "aws_subnet" "medicure_subnet" {
  vpc_id                  = aws_vpc.medicure_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.aws_zone
  tags = {
    Name = "Medicure-Subnet"
  }
}

resource "aws_security_group" "medicure_sg" {
  name        = "medicure-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.medicure_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Medicure-SG"
  }
}

resource "aws_instance" "medicure_node" {
  ami                         = var.aws_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.medicure_subnet.id
  vpc_security_group_ids      = [aws_security_group.medicure_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  tags = {
    Name = "Medicure-K8s-Node"
  }
}
