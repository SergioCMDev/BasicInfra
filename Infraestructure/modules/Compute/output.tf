output "ec2_id" {
  description = "EC2 ID"
  value       = aws_instance.ec2_instance.id
}