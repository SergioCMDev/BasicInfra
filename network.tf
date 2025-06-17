resource "aws_subnet" "publicSubnetExample1" { #public 1
    vpc_id = aws_vpc.customVPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = var.aws_availability_zones[0]
    tags = {
        Name = "publicSubnetExample1"
    }
}

resource "aws_subnet" "publicSubnetExample2" { #public 2
    vpc_id = aws_vpc.customVPC.id
    cidr_block = "10.0.3.0/24"
    availability_zone = var.aws_availability_zones[1]
    tags = {
        Name = "publicSubnetExample2"
    }
}

resource "aws_subnet" "privateSubnetExample1" { #private 1
    vpc_id = aws_vpc.customVPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.aws_availability_zones[0]
    tags = {
        Name = "privateSubnetExample1"
    }
}

resource "aws_subnet" "privateSubnetExample2" { #private 2
    vpc_id = aws_vpc.customVPC.id
    cidr_block = "10.0.4.0/24"
    availability_zone = var.aws_availability_zones[1]
    tags = {
        Name = "privateSubnetExample21e2"
    }
}