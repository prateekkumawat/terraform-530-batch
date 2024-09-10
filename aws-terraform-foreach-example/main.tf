resource "aws_vpc" "devvpc" {
  cidr_block    =  "10.0.0.0/16"
  tags = {
    Name        =  "dev-terraform-vpc"
  }
}

# create a first public subnet 
resource "aws_subnet" "devfirstpp" {
  cidr_block    =   "10.0.1.0/24"
  vpc_id        =   aws_vpc.devvpc.id
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags          =  { 
    Name        =   "dev-public-subnet"
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


# create a security group using for_each 
resource "aws_security_group" "deveach" {
  name        = "Dynamic-Blocks-SG"
  description = "Security Group built by Dynamic Blocks"
  #vpc_id = aws_vpc.devvpc.id

  dynamic "ingress" {
    for_each = ["80", "22", "443", "110", "8443"]
    content {
      description = "Allow port HTTP"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

    dynamic "ingress" {
    for_each = ["1.2.3.4/32", "10.0.0.0/16", "192.168.1.1/32"]
    content {
      description = "Allow port HTTP"
      from_port   = 888
      to_port     = 888
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# itretting single value using list variables 

# resource "aws_instance" "webset" {
#   for_each = toset(var.instance_set)
#   ami = "ami-0b08bfc6ff7069aff"
#   instance_type = "t2.micro"
   

#   tags = {
#     Name = each.value
#   }
# }

# resource "aws_instance" "by_map" {
#   for_each = var.instance_map
#   ami = "ami-0b08bfc6ff7069aff"
#   instance_type = "t2.micro"

#   tags = {
#     Name = each.value
#     ID = each.key
#   }
# }

resource "aws_instance" "by_map" {
  for_each = var.instance_map
  ami = each.value.ami
  instance_type = each.value.instance_type 

  tags = {
    Name = each.key
  }
}