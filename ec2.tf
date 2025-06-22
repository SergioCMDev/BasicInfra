data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")

  vars = {
    db_name     = aws_db_instance.wordpress_db.db_name
    db_user     = aws_db_instance.wordpress_db.username
    db_password = aws_db_instance.wordpress_db.password
    db_host     = aws_db_instance.wordpress_db.address
  }
}


resource "aws_instance" "ec2_instance" {
    ami = var.ec2_ami
    associate_public_ip_address = true
    instance_type = var.ec2_instance_type
    vpc_security_group_ids = [aws_security_group.sg_base_ec2.id,   aws_security_group.sg_front_end.id]
    subnet_id = aws_subnet.publicSubnetExample1.id
    key_name = aws_key_pair.kp_config_user.key_name
    tags = {
        Name = "Terraform_Instance"
    }
    user_data = data.template_file.user_data.rendered
}