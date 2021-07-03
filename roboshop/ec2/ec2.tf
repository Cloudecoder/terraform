resource "aws_spot_instance_request" "launch" {
  count                       = length(var.COMPONENTS)
  ami                         = "ami-059e6ca6474628ef0"
  spot_price                  = "0.0031"
  instance_type               = "t2.micro"


  tags = {
    Name                      = element(var.COMPONENTS,count.index )
  }
}
variable "COMPONENTS" {}

resource "time_sleep" "waiting" {
  depends_on                  = [aws_spot_instance_request.launch]
  create_duration             = "30s"
}

resource "aws_ec2_tag" "spot" {
  depends_on                  = [time_sleep.waiting]
  count                       = length(var.COMPONENTS)
  key                         = "name"
  resource_id                 = element(aws_spot_instance_request.launch.*.id ,count.index)
  value                       = element(var.COMPONENTS,count.index)
}

resource "aws_route53_record" "dns" {
  depends_on                  = [aws_ec2_tag.spot]
  count                       = length(var.COMPONENTS)
  name                        = "${element(var.COMPONENTS,count.index)}.roboshop.internal"
  type                        = "A"
  zone_id                     = "Z048532427Z8A2VSNE7P3"
  ttl                         = "300"
  records                     = [element(aws_spot_instance_request.launch.*.private_ip,count.index)]
}




