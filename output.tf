output "vpc_id"{
    description = "ID VPC"
    value = aws_vpc.customVPC.id
}

output "bd_id"{
    description = "ID BD"
    value = aws_db_instance.rds_free_tier.id
}

output "ec2_id"{
    description = "EC2 ID"
    value = aws_instance.ec2_instance.id
}