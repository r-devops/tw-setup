# Create A VPC 
resource "aws_vpc" "main" {
    cidr_block          =   "${var.VPC_CIDR}"
    instance_tenancy    =   "default"
    tags                = {
        Name            = "${var.PROJECT_NAME}-vpc"
    }
}

# Create IGW for Public Access 
resource "aws_internet_gateway" "gw" {
    vpc_id              = "${aws_vpc.main.id}"
    tags                = {
        Name            = "${var.PROJECT_NAME}-igw"
  }
}
