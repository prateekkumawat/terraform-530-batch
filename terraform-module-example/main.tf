terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "ec2-service" {
  source = "./modules/ec2"
}

module "vpc-service" {
    source = "./modules/vpc"
    aws_module_vpc = "10.0.0.0/16"
    aws_module_subnet = ["10.0.1.0/24", "10.0.2.0/24"]
    aws_module_az = ["ap-south-1a", "ap-south-1b"]
}

module "security_service" {
  source = "./modules/security_group"
}
