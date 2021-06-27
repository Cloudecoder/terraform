module "ec2" {
  source       = "./ec2"
  COMPONENTS   = var.COMPONENTS
}

module "ansible_apply" {
  depends_on   = [module.ec2]
  source       = "./ansible"
  COMPONENTS   = var.COMPONENTS
}