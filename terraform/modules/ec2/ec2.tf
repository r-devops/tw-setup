## Make Dynamic SSH keys
resource "null_resource" "make-ssh-keys" {
    provisioner "local-exec" {
        command                 = "yes y |ssh-keygen -q -t rsa -f deployer -N ''"
    }

    provisioner "local-exec" {
        command                 = "pwd;ls"
    }
}

### Get PEM Content
module "pem_content" {
  source                        = "matti/outputs/shell"
  command                       = "cat deployer"
}

### Get PUB Content
module "pub_content" {
  source                        = "matti/outputs/shell"
  command                       = "cat deployer.pub"
}

### Add pub key to ec2 
resource "aws_key_pair" "deployer" {
  key_name                      = "deployer-key"
  public_key                    = "${module.pub_content.stdout}"
}

### Create Instance
resource "aws_instance" "web" {
  count                         = 1
  ami                           = "${data.aws_ami.centos.id}"
  instance_type                 = "t2.small"
  key_name                      = "${aws_key_pair.deployer.key_name}"
  vpc_security_group_ids        = ["${aws_security_group.ssh-sg.id}"]
  subnet_id                     = "${element(var.PUBLIC_SUBNETS, count.index)}"

  tags                          = {
      Name                      = "${var.PROJECT_NAME}-node-${count.index}"
  }
}

output "pem_content" {
    value = "${module.pem_content.stdout}"
}