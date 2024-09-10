# create security group in exist manual project vpc 
resource "aws_security_group" "module_sec" {
  name        = "allow_ssh_web_project_module"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = {
    Name = "project_module_webserver"
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

 ingress {
    from_port       = 80
    to_port         = 80
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
