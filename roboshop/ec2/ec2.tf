resource "aws_spot_instance_request" "spot_instance" {
  count                    = length(var.COMPONENTS)
  ami                      = "ami-059e6ca6474628ef0"
  spot_price               = "0.0031"
  instance_type            = "t2.micro"
  vpc_security_group_ids   = [""]

  tags                 = {
    Name               = element(var.COMPONENTS, count.index )
  }
}

variable "COMPONENTS" {}


resource "time_sleep" "wait_30_seconds" {
  depends_on           = [aws_spot_instance_request.spot_instance]

  create_duration      = "60s"
}

resource "aws_ec2_tag" "spot" {
  depends_on           = [time_sleep.wait_30_seconds]
  count                = length(var.COMPONENTS)
  key                  = "name"
  resource_id          = element(aws_spot_instance_request.spot_instance.*.spot_instance_id, count.index )
  value                = element(var.COMPONENTS, count.index)
}


resource "aws_route53_record" "dns" {
  depends_on           = [time_sleep.wait_30_seconds]
  count                = length(var.COMPONENTS)
  zone_id              = "Z048532427Z8A2VSNE7P3"
  name                 = "${element(var.COMPONENTS, count.index )}.roboshop.internal"
  type                 = "A"
  ttl                  = "300"
  records              = [element(aws_spot_instance_request.spot_instance.*.private_ip, count.index )]
}