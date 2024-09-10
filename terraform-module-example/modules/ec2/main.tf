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