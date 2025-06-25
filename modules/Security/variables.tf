variable "repo_owner" {
  type        = string
  description = "Nombre del usuario u organización en GitHub"
}

variable "repo_name" {
  type        = string
  description = "Nombre del repositorio en GitHub"
}

variable "aws_account_id" {
  type = string
}

variable "public_ip" {
  type        = string
  description = "self public ip"
  sensitive   = true
}


variable "customVPC_id"{
  type = string
}

variable "github_openid_provider" {
  type = string
}