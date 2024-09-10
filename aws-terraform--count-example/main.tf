
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
    count = 2
    ami = var.aws_ami
    instance_type = var.aws_instance
    key_name = aws_key_pair.mykey_pair.key_name
    security_groups = ["launch-wizard-57"]
    
    tags = {
    
        Name = "First_Instance_${count.index}"
    }
}

