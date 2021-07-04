resource "null_resource" "ansible" {
  triggers = {
    abc = timestamp()
  }
  count                = length(var.COMPONENTS)
  provisioner "remote-exec" {
    connection {
      host = " ${element(var.COMPONENTS,count.index)}.roboshop.internal"
      user = "centos"
      password = "DevOps321"
    }
    inline = [
      "sudo yum install ansible -y",
      "sudo yum remove ansible -y",
      "sudo rm -rf /usr/lib/python2.7/site-packages/ansible*",
      "sudo pip install ansible=3.4.0",
      "ansible-pull -i localhost, -U https://github.com/Cloudecoder/ansible.git ansible-pull.yml -e COMPONENT=${element(var.COMPONENTS,count.index)}"
    ]

  }
}



variable "COMPONENTS" {}















