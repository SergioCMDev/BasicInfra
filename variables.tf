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


variable "ec2_ami"{
    type = string
    description = "AMI"
    default = "ami-015b1e8e2a6899bdb" #Amazon Linux
}

variable "ec2_instance_type"{
    type = string
    description = "Instance type"
    default = "t2.micro"
}