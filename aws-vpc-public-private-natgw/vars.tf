variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "vpc_cidr_block" {}
variable "aws_subnet_cidr" {
  type = list  
}
variable "aws_subnet_az" {
   type = list
}
variable "vpc_project_id" {}
variable "vpc_project_subnet_id" {
  type = list 
}