variable "server" {
  default = ["prometheus","node_exporter"]
}

output "number_of_instance" {
  value = length(var.server)
}

output "name_of_instance" {
  value = element(var.server , count.index)
}