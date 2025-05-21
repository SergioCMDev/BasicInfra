# Routing table for public subnet (access to the Internet)
# Using in-line routes 
resource "aws_route_table" "rt-pub-main" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-pub-main"
  }
}

# Set new main_route_table as main
resource "aws_main_route_table_association" "rta-default" {
  vpc_id = aws_vpc.example.id
  route_table_id = aws_route_table.rt-pub-main.id
}


# Routing table for private subnet in Availability Zone A 
# Using standalone routes resources 
resource "aws_route_table" "rt-priv-za" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "rt-priv-za"
  }
}

# Route Access to the Internet through NAT  (Av. Zone A)
resource "aws_route" "rt-priv-za-ngw-za" {
  route_table_id         = aws_route_table.rt-priv-za.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.aws_nat_gateway_pub_ZA.id
}

# Routing Table Association for Subnet ditwl-sn-za-pro-pri-02
resource "aws_route_table_association" "ditwl-rta-za-pro-pri-02" {
  subnet_id      = aws_subnet.privateSubnetExample1.id
  route_table_id = aws_route_table.rt-priv-za.id
}

# Routing table for private subnet in Availability Zone B
# Using standalone routes resources 
resource "aws_route_table" "rt-priv-zb" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "rt-priv-zb"
  }
}
# Routing Table Association for Subnet ditwl-sn-zb-pro-pri-06
resource "aws_route_table_association" "rta-zb-privateSubnetExample2" {
  subnet_id      = aws_subnet.privateSubnetExample2.id
  route_table_id = aws_route_table.rt-priv-zb.id
}
# Route Access to the Internet through NAT (Av. Zone B)
resource "aws_route" "rt-priv-zb-ngw-zb" {
  route_table_id         = aws_route_table.rt-priv-zb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.aws_nat_gateway_pub_ZB.id
}

