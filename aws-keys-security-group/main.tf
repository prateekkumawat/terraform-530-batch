# that intial terraform code for aws provider 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

# add security keys for connect your aws account 

provider "aws" {
  access_key = "xxxxxxxx"
  secret_key = "xxxxxxxx"
  region = "ap-south-1"
}

# create aws key pair for aws 
resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 4096 
}

resource "aws_key_pair" "mykey_pair" {
  key_name   = "mykey.pem"
  public_key = tls_private_key.mykey.public_key_openssh
}

resource "local_file" "mykey_file" {
   filename = "mykey.pem"
   content = tls_private_key.mykey.private_key_pem
}

# create a ec2 instance 
resource "aws_instance" "firstinstance" {
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name = aws_key_pair.mykey_pair.key_name
    security_groups = ["launch-wizard-57"]
    
    tags = {
    
        Name = "First_Instance"
    }
}

