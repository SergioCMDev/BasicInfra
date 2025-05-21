resource "aws_subnet" "publicSubnetExample1" { #public 1
    vpc_id = aws_vpc.example.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "publicSubnetExample1"
    }
}

resource "aws_subnet" "publicSubnetExample2" { #public 2
    vpc_id = aws_vpc.example.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-1b"
    tags = {
        Name = "publicSubnetExample2"
    }
}

resource "aws_subnet" "privateSubnetExample1" { #private 1
    vpc_id = aws_vpc.example.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-1a"
    tags = {
        Name = "privateSubnetExample1"
    }
}

resource "aws_subnet" "privateSubnetExample2" { #private 1
    vpc_id = aws_vpc.example.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "eu-west-1b"
    tags = {
        Name = "privateSubnetExample21e2"
    }
}