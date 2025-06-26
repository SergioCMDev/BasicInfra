variable "aws_region" {
  type        = string
  description = "aws_region"
}

variable "db_username" {
  type        = string
  description = "db_username"
}

variable "db_password" {
  type        = string
  description = "db_password"
}

variable "db_name" {
  type        = string
  description = "db_name"
}

variable "aws_account_id" {
  type        = string
  description = "aws_account_id"
}

variable "public_ip" {
  type        = string
  description = "public_ip"
}

variable "aws_availability_zones" {
  type        = list(any)
  description = "Availability zones"
}
