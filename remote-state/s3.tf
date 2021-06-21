resource "aws_instance" "sample" {
  ami                    = "ami-059e6ca6474628ef0"
  instance_type          = "t2.micro"

}

terraform {
  backend "s3" {
    bucket               = "storetf"
    key                  = "sample/terraform.tfstate"
    region               = "us-east-1"
  }
}

provider "aws" {
  region                 = "us-east-1"
}