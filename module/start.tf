module "instance" {
  source = "./instance"
  sg_id = module.security_group.sg_id
}

module "security_group" {
  source = "./security_group"

}