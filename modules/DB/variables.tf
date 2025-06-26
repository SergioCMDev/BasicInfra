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

variable "db_name" {
  type        = string
  description = "db name"
  sensitive   = true
}

variable "db_subnet_group_name" {
  type = string
}

variable "db_security_group_id" {
  type = string
}