resource "aws_spot_instance_request" "launch" {
  count                = length(var.COMPONENTS )
  ami                  = "ami-059e6ca6474628ef0"
  instance_type        = "t2.micro"
  spot_price           = "0.0031"

  tags = {
    name               = element(var.COMPONENTS,count.index )
  }
}
