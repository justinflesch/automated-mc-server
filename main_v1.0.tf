terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
  shared_credentials_files = ["C:/Windows/System32/.aws/credentials"]
}

resource "aws_security_group" "mc_security" {
  name = "mc-security-group"
  description = "A security group for a Minecraft server"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "udp"
    from_port = 19132
    to_port = 19132
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "mc_server" {
  ami           = "ami-03f65b8614a860c29"
  instance_type = "t2.medium"

  tags = {
    Name = "MinecraftServer"
  }

  key_name = "dc_key"

  vpc_security_group_ids = [aws_security_group.mc_security.id]
}
