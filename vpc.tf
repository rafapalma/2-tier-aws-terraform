# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block = "10.1.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "${var.prefix}-vpc"
    }
}

# Create Subnets
resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.1.10.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = {
      "Name" = "${var.prefix}-public-subnet"
    }
}

resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.1.20.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-east-1a"
    tags = {
      "Name" = "${var.prefix}-private-subnet"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "internet_gw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      "Name" = "${var.prefix}-gateway"
    }
}

# Create Route Tables
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      "Name" = "${var.prefix}-public-route-table"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      "Name" = "${var.prefix}-private-route-table"
    }
}

resource "aws_default_route_table" "slvpn_main_route_table" {
    default_route_table_id = aws_vpc.vpc.default_route_table_id
    tags = {
        "Name" = "${var.prefix}-main-route-table"
    }
}

# Create Routes
resource "aws_route" "default-route" {
    route_table_id = aws_route_table.public-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
}

# Create Route Associations
resource "aws_route_table_association" "public-route-table" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route-table" {
    subnet_id = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.private-route-table.id
}
