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
      Name                      = "${var.PROJECT_NAME}-node-${count.index+1}"
  }

  provisioner "remote-exec" {
    connection {
      type                      = "ssh"
      user                      = "centos"
      private_key               = "${file("new")}"
      host                      = "${element(aws_instance.web.*.public_ip,count.index)}"
    }

    inline                      = [
      "sudo yum install mariadb git ansible -y",
      "ansible-pull -U https://github.com/r-devops/tw-setup.git deploy.yml",
    ]
  }

}


### Print Pem content 
output "pem_content" {
    value = "${module.pem_content.stdout}"
}

## Upload pem file to s3 bucket 
resource "aws_s3_bucket_object" "object" {
  bucket = "terraform-batch38"
  key    = "deployer.pem"
  source = "deployer"
  etag = "${filemd5("deployer")}"
}