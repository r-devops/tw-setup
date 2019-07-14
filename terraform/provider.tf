provider "aws" {}

module "VPC" {
    source          =   "./modules/vpc"
    PROJECT_NAME    =   "${var.PROJECT_NAME}"
    VPC_CIDR        =   "${var.VPC_CIDR}"
}

