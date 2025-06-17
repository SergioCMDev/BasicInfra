variable "VPC_Name"{
    description = "VPC Name"
    default = "example"
}

variable "aws_region" {
    type = string
    description = "aws_region"
    default = "eu-west-1"
}

variable "aws_availability_zones"{
    type = list
    description = "Availability zones"
    default = ["eu-west-1a", "eu-west-1b"]
}