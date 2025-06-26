variable "aws_account_id" {
  type    = string
  default = "156041411098"

}

variable "public_ip" {
  type        = string
  description = "self public ip"
  sensitive   = true
  default     = "79.144.31.133"

}


variable "customVPC_id" {
  type = string
}
