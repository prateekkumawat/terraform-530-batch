resource "aws_vpc" "devvpc" {
  cidr_block    =  var.vpc_cidr_block
  tags = {
    Name        =  "dev-terraform-vpc"
  }
}

# create a first public subnet 
resource "aws_subnet" "devfirstpp" {
  cidr_block    =   var.aws_subnet_cidr[0]
  vpc_id        =   aws_vpc.devvpc.id
  availability_zone = var.aws_subnet_az[0]
  map_public_ip_on_launch = "true"
  tags          =  { 
    Name        =   "dev-public-subnet"
  }
}

# create a first private subnet 
resource "aws_subnet" "devfirstps" {
  cidr_block    =   var.aws_subnet_cidr[1]
  vpc_id        =   aws_vpc.devvpc.id
  availability_zone = var.aws_subnet_az[1]
  map_public_ip_on_launch = "false"
  tags          =  { 
    Name        =   "dev-private-subnet"
  }
}

# create internet gateway for aws vpc 
resource "aws_internet_gateway" "devfirstigw" {
  vpc_id        =  aws_vpc.devvpc.id

  tags = {
    Name        =  "dev-first-igw"
  }
}

# create a public route tables for vpc 
resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devfirstigw.id
  }

  tags = {
    Name = "dev-first-publicrt"
  }
}

# attach public subnet with public rt 
resource "aws_route_table_association" "attachpublicrt" {
  subnet_id      = aws_subnet.devfirstpp.id
  route_table_id = aws_route_table.publicrt.id
}