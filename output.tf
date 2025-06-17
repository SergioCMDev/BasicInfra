output "vpc_id"{
    description = "ID VPC"
    value = "aws_vpc.main_id"
}

output "bd_id"{
    description = "ID BD"
    value = "aws_db_instance.rds_free_tier.id"
}