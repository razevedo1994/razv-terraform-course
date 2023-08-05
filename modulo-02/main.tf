terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
    ami             = var.ami
    instance_type   = var.instance_type
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true
    
    tags = {
      Name = var.project_name
    }
}

resource "aws_security_group" "instance" {
    name = "${var.project_name}-instance"

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}