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

# add a nat gateway service in vpc**********************
# Create a Eip for nat gateway
resource "aws_eip" "ngweip" {
  domain = "vpc" 
  tags = {
    Name = "dev-first-nat-eip"
  }
}

# Create a nat gateway for vpc
resource "aws_nat_gateway" "devfirstnatgw" {
  subnet_id = aws_subnet.devfirstpp.id
  allocation_id = aws_eip.ngweip.id
  tags = {
    Name = "dev-first-nat-gw"
  }
}

# create a private route tables for vpc 
resource "aws_route_table" "privatecrt" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.devfirstnatgw.id
  }

  tags = {
    Name = "dev-first-privatecrt"
  }
}

# attach private subnet with private rt 
resource "aws_route_table_association" "attachprivatecrt" {
  subnet_id      = aws_subnet.devfirstps.id
  route_table_id = aws_route_table.privatecrt.id
}

# gather information vpc info already manual created
data "aws_vpc" "projectvpc" {
  id = var.vpc_project_id
}

# gather information of already exist subnetes 
data "aws_subnet" "projectvpc_subnetpub1" {
  id = var.vpc_project_subnet_id[0]
}

data "aws_subnet" "projectvpc_subnetpub2" {
  id = var.vpc_project_subnet_id[2]
}

data "aws_subnet" "projectvpc_subnetpriv1" {
  id = var.vpc_project_subnet_id[1]
}

data "aws_subnet" "projectvpc_subnetpriv2" {
  id = var.vpc_project_subnet_id[3]
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
    vpc_security_group_ids = ["aws_security_group.projectvpcsec.id"] 
    subnet_id = data.aws_subnet.projectvpc_subnetpub1.id

    tags = {
        Name = "First_Instance"
    }
 }

# create security group in exist manual project vpc 
resource "aws_security_group" "projectvpcsec" {
  name        = "allow_ssh_project_vpc"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.projectvpc.id

  tags = {
    Name = "project_vpc_rule_ins"
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     =  ["0.0.0.0/0"]
  }
}
