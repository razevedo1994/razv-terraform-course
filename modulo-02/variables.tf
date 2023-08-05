variable "region" {
  type = string
  description = "Region for deployment"
}

variable "instance_type" {
  type = string
  description = "Type of instance"
}

variable "ami" {
  type = string
  description = "Image of ec2 instance"
}

variable "project_name" {
  type = string
  description = "Name of the project"
}

