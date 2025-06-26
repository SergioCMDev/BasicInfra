variable "ec2_ami" {
  type        = string
  description = "AMI"
  default     = "ami-06b616cc0183ad7dd" #Amazon Linux
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type"
  default     = "t2.micro"
}


variable "sg_base_ec2_id"{
  type = string
}

variable "sg_front_end_id"{
  type = string
}

variable "public_subnet1_id" {
  type = string
}

variable "db_user_data"{
type = string
}