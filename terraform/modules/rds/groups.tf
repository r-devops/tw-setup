## Subnet Group using Private Subnets
resource "aws_db_subnet_group" "mariadb" {
    name                        = "mariadb"
    subnet_ids                  = "${var.PRIVATE_SUBNETS}"

    tags                        = {
        Name                    = "${var.PROJECT_NAME}-RDS-SubnetGroup"
  }
}

## Create Parameter Group for MariaDB
resource "aws_db_parameter_group" "mariadb" {
    name                        = "mariadb-rds"
    family                      = "mariadb10.3"
}

## Create Security Group for MariaDB access , Only inside VPC

resource "aws_security_group" "rds-sg" {
    name                        = "allow-mariadb-internal"
    description                 = "Allow MariaDB Access Internal"
    vpc_id                      = "${var.VPC_ID}"

    ingress {
      from_port                 = 443
      to_port                   = 443
      protocol                  = "-1"
      cidr_blocks               = ["${var.VPC_CIDR}"]
    }

    egress {
      from_port                 = 0
      to_port                   = 0
      protocol                  = "-1"
      cidr_blocks               = ["0.0.0.0/0"]
    }
}