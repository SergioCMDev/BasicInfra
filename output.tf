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