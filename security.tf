# Create a "base" Security Group for EC2 instances
resource "aws_security_group" "sg-base-ec2" {
  name        = "aws-sg-base-ec2"
  vpc_id      = aws_vpc.example.id
  description = "Base security Group for EC2 instances"
}
# DANGEROUS!!
# Allow access from the Internet to port 22 (SSH) in the Public EC2 instances
resource "aws_security_group_rule" "sr-internet-to-ec2-ssh" {
  security_group_id = aws_security_group.sg-base-ec2.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Internet
  description       = "Allow access from the Internet to port 22 (SSH)"
}
# Allow access from the Internet for ICMP protocol (e.g. ping) to the EC2 instances
resource "aws_security_group_rule" "sr-internet-to-ec2-icmp" {
  security_group_id = aws_security_group.sg-base-ec2.id
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"] # Internet
  description       = "Allow access from the Internet for ICMP protocol"
}
# Allow all outbound traffic to the Internet
resource "aws_security_group_rule" "sr-all-outbund" {
  security_group_id = aws_security_group.sg-base-ec2.id
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic to Internet"
}


# Create a Security Group for the Front end Server
resource "aws_security_group" "sg-front-end" {
  name        = "aws-sg-front-end"
  vpc_id      = aws_vpc.example.id
  description = "Front end Server Security"
}
# Allow access from the Internet to port 80 HTTP in the EC2 instances
resource "aws_security_group_rule" "sr-internet-to-front-end-http" {
  security_group_id = aws_security_group.sg-front-end.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # Internet
  description       = "Access from the Internet to port 80 in the EC2 instances"
}


# Create a Security Group for the Back-end Server
resource "aws_security_group" "sg-back-end" {
  name        = "aws-sg-back-end"
  vpc_id      = aws_vpc.example.id
  description = "Back-end Server Security"
}
# Allow access from the front-end to port 8080 in the back-end API
resource "aws_security_group_rule" "sr-front-end-to-api" {
  security_group_id        = aws_security_group.sg-back-end.id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg-front-end.id
  description              = "Allow access from the front-end to port 8080 in the back-end API"
}

# Upload a Private Key Pair for SSH Instance Authentication
resource "aws_key_pair" "kp-config-user" {
  key_name   = "kp-config-user"
  public_key = file("id_rsa.pub")
}