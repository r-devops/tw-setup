output "rds-endpoint" {
  value = "${aws_db_instance.mariadb-rds.address}"
}
