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
