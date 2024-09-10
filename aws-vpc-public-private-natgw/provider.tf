terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-530-batch"
    key    = "tfstate"
    region = "ap-south-1"
  }
}

# add security keys for connect your aws account 

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}