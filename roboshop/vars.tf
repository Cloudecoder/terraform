variable "COMPONENTS" {
  default = ["frontend","mongodb","catalogue","mysql","redis","cart","user","rabbitmq","payment","shipping"]
}

output "number_of_instance" {
  value = length(var.COMPONENTS)
}

output "instance" {
  value = element(var.COMPONENTS)
}