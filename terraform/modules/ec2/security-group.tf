resource "aws_security_group" "ssh-sg" {
    name                        = "allow-ssh-external"
    description                 = "Allow SSH Access External"
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


resource "aws_security_group" "http-sg-ext" {
    name                        = "allow-http-external"
    description                 = "Allow HTTP Access External"
    vpc_id                      = "${var.VPC_ID}"

    ingress {
      from_port                 = 80
      to_port                   = 80
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

resource "aws_security_group" "http-sg-int" {
    name                        = "allow-http-internal"
    description                 = "Allow HTTP Access Internal"
    vpc_id                      = "${var.VPC_ID}"

    ingress {
      from_port                 = 80
      to_port                   = 80
      protocol                  = "TCP"
      cidr_blocks               = ["${var.VPC_CIDR}"]
    }

    egress {
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      cidr_blocks               = ["0.0.0.0/0"]
    }
}