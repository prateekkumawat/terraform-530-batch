resource "aws_vpc" "vpc1" {
  cidr_block = var.aws_module_vpc
  tags = {
    Name = "module-vpc"
  }
}

resource "aws_subnet" "pubsubnet" {
  cidr_block = var.aws_module_subnet[0]
  availability_zone = var.aws_module_az[0]
  vpc_id = aws_vpc.vpc1.id
  tags = { 
    Name = "module-vpc-subnet-public"
  }
}

resource "aws_subnet" "privsubnet" {
  cidr_block = var.aws_module_subnet[1]
  availability_zone = var.aws_module_az[1]
  vpc_id = aws_vpc.vpc1.id
  tags = { 
    Name = "module-vpc-subnet-private"
  }
}