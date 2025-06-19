variable "aws_region" {
    type = string
    description = "aws_region"
}

variable "aws_availability_zones"{
    type = list
    description = "Availability zones"
}

variable "ec2_ami"{
    type = string
    description = "AMI"
    default = "ami-06b616cc0183ad7dd" #Amazon Linux
}

variable "ec2_instance_type"{
    type = string
    description = "Instance type"
    default = "t2.micro"
}

variable "public_ip" {
    type = string
    description = "self public ip"
}

variable "db_name" {
    type = string
    description = "db name"
}

variable "db_username" {
    type = string
    description = "db username"
}

variable "db_password" {
    type = string
    description = "db password"
}