## Subnet Group using Private Subnets
resource "aws_db_subnet_group" "mariadb" {
    name                        = "mariadb"
    subnet_ids                  = ["${var.PRIVATE_SUBNETS}"]

    tags                        = {
        Name                    = "${var.PROJECT_NAME}-RDS-SubnetGroup"
  }
}