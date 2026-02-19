# This file defines the Terraform provider configuration for AWS. 
# It specifies that the AWS provider is required and sets the version
# constraint to "~> 3.0". The provider block configures the AWS provider
# to use the "us-west-2" region for all AWS resources defined in the 
# Terraform configuration. This setup allows Terraform to interact with 
# AWS services and manage resources in the specified region.    

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}
