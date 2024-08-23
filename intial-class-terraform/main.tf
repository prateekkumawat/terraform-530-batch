# terraform always use *.tf files. 
//
// terraform sstuctures are having multiple files that describe below 
// 1. main.tf : your whole infra and resource details 
// 2. vars.tf : that files used for variables 
// 3. output.tf  : that used for manage your outputs like your instance ip, elb url, rds endpoints
// 4. provider.tf : that help you define providers in terraform code aws azure gcp 
// 5. *.tfvars/*.auto.tfvars : contain variable values 

# terraform structures 

# define providers in your code 

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.1"
    }
  }
}

# this is most required module that define which cloud your are using and 
# whatever resource like ec2 rds vpc or somthing else you want to create that supported lib are provided by provider.

provider "aws" {
  access_key = "xxxxxx"
  secret_key = "xxxxxx"
  region = "ap-south-1"
}

# create a instance ec2 in Mumbai region 
resource "aws_instance" "firstinstance" {
// aws_instnce is a resource that tell you what type of service you use in that section. 
//firstinstance is a identfires that help to call this service in code anywhere.
ami = "ami-02b49a24cfb95941c"
instance_type = "t2.micro"
key_name = "op"
security_groups = ["launch-wizard-57"]
tags = {
  Name = "First_Instance"
}
}

output "instance_pip" {
  value = aws_instance.firstinstance.public_ip
}

