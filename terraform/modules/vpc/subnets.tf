
#Create Public Subnets
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

# Create Private Subnets
resource "aws_subnet" "private-subnets" {
    count                       = "${length(data.aws_availability_zones.available)}"
    vpc_id                      = "${aws_vpc.main.id}"
    cidr_block                  = "${cidrsubnet(var.VPC_CIDR, 8, count.index+length(data.aws_availability_zones.available))}"
    availability_zone           = "${element(data.aws_availability_zones.available.names, count.index)}"
    map_public_ip_on_launch     = true

    tags = {
        Name                    = "${var.PROJECT_NAME}-Private-Subnet-${count.index+1}"
  }
}

# Create Route  for Public Subnets
resource "aws_route_table" "public-rt" {
    vpc_id                      = "${aws_vpc.main.id}"

    route {
      cidr_block                = "0.0.0.0/0"
      gateway_id                = "${aws_internet_gateway.gw.id}"
    }

    tags                        = {
        Name                    = "${var.PROJECT_NAME}-Public-RT"
    }
}

# Create Route  for Private Subnets
resource "aws_route_table" "private-rt" {
    vpc_id                      = "${aws_vpc.main.id}"

    tags                        = {
        Name                    = "${var.PROJECT_NAME}-Private-RT"
    }
}

## Associate Public-Route table to Public Subnet
resource "aws_route_table_association" "public-assoc" {
    count                       = "${length(data.aws_availability_zones.available)}"
    subnet_id                   = "${element(aws_subnet.public-subnets.*.id,count.index)}"
    route_table_id              = "${aws_route_table.public-rt.id}"
}

## Associate Private-Route table to Private Subnet
resource "aws_route_table_association" "private-assoc" {
    count                       = "${length(data.aws_availability_zones.available)}"
    subnet_id                   = "${element(aws_subnet.private-subnets.*.id,count.index)}"
    route_table_id              = "${aws_route_table.private-rt.id}"
}