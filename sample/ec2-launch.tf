resource "aws_spot_instance_request" "ec2" {
  ami               = "ami-059e6ca6474628ef0"
  instance_type     = "t2.micro"
  security_groups   = [aws_security_group.allow_ssh.id]
}

resource "aws_ec2_tag" "ec2" {
  resource_id = aws_spot_instance_request.ec2.id
  key         = ["Name"]
  value       = ["server1"]
  depends_on = [aws_spot_instance_request.ec2]
}

resource "aws_ec2_tag" "tag" {
  resource_id = aws_spot_instance_request.ec2.id
  key         = ["monitor"]
  value       = ["yes"]
  depends_on = [aws_spot_instance_request.ec2]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    description      = "allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

provider "aws" {
  region = "us-east-1"
}