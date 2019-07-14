resource "aws_db_instance" "mariadb-rds" {
    identifier                              = "wiki-rds"
    allocated_storage                       = 20
    storage_type                            = "gp2"
    engine                                  = "mariadb"
    engine_version                          = "10.3"
    instance_class                          = "db.t2.micro"
    name                                    = "wiki"
    username                                = "${var.DBUSER}"
    password                                = "${var.DBPASS}"
    parameter_group_name                    = "${aws_db_parameter_group.mariadb.id}"
    db_subnet_group_name                    = "${aws_db_subnet_group.mariadb.id}"
    vpc_security_group_ids                  = ["${aws_security_group.rds-sg.id}"]
    skip_final_snapshot                     = true ## Optionally enabled for deleting through terraform
    tags                                    = {
        Name                                = "${var.PROJECT_NAME}-rds"
    }
}