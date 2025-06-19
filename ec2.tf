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

    
    user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y httpd php php-mysqlnd php-fpm php-opcache php-gd php-curl php-mbstring php-xml php-json php-dom

              systemctl enable --now httpd
              echo "¡Hello world!" > /var/www/html/index.html

              cd /tmp
              wget https://wordpress.org/latest.tar.gz
              tar -xzvf latest.tar.gz

              rm -f /var/www/html/index.html
              cp -r wordpress/* /var/www/html/
              chown -R apache:apache /var/www/html
              chmod -R 755 /var/www/html

              systemctl restart httpd
              EOF
}
