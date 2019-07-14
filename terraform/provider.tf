provider "aws" {}

terraform {
    backend "s3" {
        bucket = "terraform-batch38"
        key    = "mediawiki/terraform.tfstate"
        region = "us-east-1"
  }
}


module "VPC" {
    source          =   "./modules/vpc"
    PROJECT_NAME    =   "${var.PROJECT_NAME}"
    VPC_CIDR        =   "${var.VPC_CIDR}"
}

