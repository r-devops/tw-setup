resource "null_resource" "make-ssh-keys" {
    provisioner "local-exec" {
        command = "yes y |ssh-keygen -q -t rsa -f deployer -N ''"
    }

    provisioner "local-exec" {
        command = "pwd;ls"
    }
}

module "pem_content" {
  source = "matti/outputs/shell"
  command = "cat deployer"
}

output "pem_content" {
    value = "${module.pem_content.stdout}"
}