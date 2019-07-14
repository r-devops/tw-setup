resource "null_resource" "make-ssh-keys" {
    provisioner "local-exec" {
        command = "yes y |ssh-keygen -q -t rsa -f deployer -N ''"
    }

    provisioner "local-exec" {
        command = "pwd;ls"
    }
}

output "pem_content" {
    value = "nothing"
}