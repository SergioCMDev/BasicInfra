resource "aws_instance" "ec2_instance" {
    ami = var.ec2_ami
    associate_public_ip_address = true
    instance_type = var.ec2_instance_type
    vpc_security_group_ids = [aws_security_group.sg_base_ec2.id]
    subnet_id = aws_subnet.publicSubnetExample1.id
    key_name = aws_key_pair.kp_config_user.key_name
    tags = {
        Name = "Terraform_Instance"
    }
}
