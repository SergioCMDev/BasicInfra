variable "aws_region" {
  type        = string
  description = "aws_region"
}

variable "aws_availability_zones" {
  type        = list(any)
  description = "Availability zones"
}

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

variable "public_ip" {
  type        = string
  description = "self public ip"
  sensitive   = true
}

variable "db_name" {
  type        = string
  description = "db name"
  sensitive   = true
}

variable "db_username" {
  type        = string
  description = "db username"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "db password"
  sensitive   = true
}

variable "aws_account_id" {
  type = string
}

variable "repo_owner" {
  type        = string
  description = "Nombre del usuario u organización en GitHub"
}

variable "repo_name" {
  type        = string
  description = "Nombre del repositorio en GitHub"
}