output "sg_base_ec2_id"{
    value = aws_security_group.sg_base_ec2.id
}

output "sg_front_end_id"{
    value = aws_security_group.sg_front_end.id
}

output "sg_rds_id" {
  value = aws_security_group.sg_rds.id
}