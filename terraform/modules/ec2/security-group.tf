resource "aws_security_group" "ssh-sg" {
    name                        = "allow-ssh-external"
    description                 = "Allow SHH Access External"
    vpc_id                      = "${var.VPC_ID}"

    ingress {
      from_port                 = 22
      to_port                   = 22
      protocol                  = "TCP"
      cidr_blocks               = ["0.0.0.0/0"]
    }

    egress {
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      cidr_blocks               = ["0.0.0.0/0"]
    }
}

