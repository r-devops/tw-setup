resource "aws_subnet" "public-subnets" {
    count                       = "${length(data.aws_availability_zones.available)}"
    vpc_id                      = "${aws_vpc.main.id}"
    cidr_block                  = "${cidrsubnet(var.VPC_CIDR, 8, count.index)}"
    availability_zone           = "${element(data.aws_availability_zones.available.names, count.index)}"
    map_public_ip_on_launch     = true

    tags = {
        Name                    = "${var.PROJECT_NAME}-Public-Subnet-${count.index+1}"
  }
}