output "vpc_id" {
  description = "ID VPC"
  value       = aws_vpc.customVPC.id
}

output "bd_id" {
  description = "ID BD"
  value       = aws_db_instance.wordpress_db.id
}

output "ec2_id" {
  description = "EC2 ID"
  value       = aws_instance.ec2_instance.id
}

output "db_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

output "db_name" {
  value = aws_db_instance.wordpress_db.db_name
}

output "db_username" {
  value = aws_db_instance.wordpress_db.username
}

output "db_password" {
  value     = aws_db_instance.wordpress_db.password
  sensitive = true
}

output "aws_iam_arn" {
  value     = aws_iam_role.github_actions_role.arn
  sensitive = true
}