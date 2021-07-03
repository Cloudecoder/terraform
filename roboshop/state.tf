terraform {
  backend "s3" {
    bucket           = "storetf"
    key              = "roboshop/tfstate"
    region           = "us-east-1"
    dynamodb_table   = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
}