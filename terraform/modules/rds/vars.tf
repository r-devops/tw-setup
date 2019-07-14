variable "PROJECT_NAME" {}
variable "VPC_CIDR" {}

variable "VPC_ID" {}   
variable "PUBLIC_SUBNETS" {
    type = "list"
} 
variable "PRIVATE_SUBNETS" {
    type = "list"
}