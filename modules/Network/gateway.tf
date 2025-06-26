resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.customVPC.id
  tags = {
    Name = "igw"
  }
}

# NAT Gateway Public Availability Zone: A
resource "aws_nat_gateway" "aws_nat_gateway_pub_ZA" {
  subnet_id     = aws_subnet.publicSubnetExample1.id
  allocation_id = aws_eip.eip-ngw-za.id
  tags = {
    Name = "aws_nat_gateway_pub_ZA"
  }
  depends_on = [aws_internet_gateway.igw]
}


# NAT Gateway Public Availability Zone: B
resource "aws_nat_gateway" "aws_nat_gateway_pub_ZB" {
  subnet_id     = aws_subnet.publicSubnetExample2.id
  allocation_id = aws_eip.eip-ngw-zb.id
  tags = {
    Name = "aws_nat_gateway_pub_ZB"
  }
  depends_on = [aws_internet_gateway.igw]
}