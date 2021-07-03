terraform {
  backend "s3" {
    bucket           = "storetf"
    key              = "terraform/tfstate"
    region           = "us-east-1"
    dynamodb_table   = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
}