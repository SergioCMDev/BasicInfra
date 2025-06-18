resource "aws_instance" "ec2_instance" {
    ami = var.ec2_ami
    instance_type = var.ec2_instance_type
    vpc_security_group_ids = [aws_security_group.sg_back_end.id]
    subnet_id = aws_subnet.privateSubnetExample1.id
    tags = {
        Name = "Terraform_Instance"
    }
}
