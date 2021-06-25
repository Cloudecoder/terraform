resource "aws_instance" "sample" {
  ami                     = "ami-059e6ca6474628ef0"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [var.sg_id]
}


variable "sg_id" {}

provider "aws" {
  region = "us-east-1"
}