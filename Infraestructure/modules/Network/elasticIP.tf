# EIP for NAT Gateway in AZ A
resource "aws_eip" "eip-ngw-za" {
  domain = "vpc"
  tags = {
    Name = "eip-ngw-za"
  }
}

# EIP for NAT Gateway in AZ B
resource "aws_eip" "eip-ngw-zb" {
  domain = "vpc"
  tags = {
    Name = "eip-ngw-zb"
  }
}