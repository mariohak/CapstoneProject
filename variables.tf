# This file defines the input variables for the Terraform configuration,
# including project name, AWS region, availability zones, VPC CIDR block,
# subnet CIDR blocks, instance type, key pair name, SSH ingress CIDR,
# database name, username, password, instance class, and Multi-AZ setting.
# These variables allow for customization of the infrastructure deployment,
# making it flexible and adaptable to different environments and requirements.


variable "project_name" {
  type    = string
  default = "capstone-project"
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "azs" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_pair_name" {
  type    = string
  default = "vockey"
}

variable "ssh_ingress_cidr" {
  type        = string
  description = "Your public IP in CIDR form, e.g. 1.2.3.4/32"
  default     = "0.0.0.0/0"
}

variable "db_name" {
  type    = string
  default = "wordpress"
}

variable "db_username" {
  type    = string
  default = "wordpressuser"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_multi_az" {
  type        = bool
  description = "Sandbox-safe default is false (lab restricts standby / Multi-AZ). Set true only if allowed."
  default     = false
}
