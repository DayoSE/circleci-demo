# Internet VPC
resource "aws_vpc" "spring4shell-dev-vpc-main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "spring4shell-dev-vpc-main"
  }
}

# Subnets
resource "aws_subnet" "spring4shell-dev-main-public" {
  vpc_id                  = aws_vpc.spring4shell-dev-vpc-main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "spring4shell-dev-main-public"
  }
}

resource "aws_subnet" "spring4shell-dev-main-public-2" {
  vpc_id                  = aws_vpc.spring4shell-dev-vpc-main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "spring4shell-dev-main-public-2"
  }
}


resource "aws_subnet" "spring4shell-dev-main-public-3" {
  vpc_id                  = aws_vpc.spring4shell-dev-vpc-main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "spring4shell-dev-main-public-3"
  }
}



# Internet GW
resource "aws_internet_gateway" "spring4shell-dev-main-internet-gw" {
  vpc_id  = aws_vpc.spring4shell-dev-vpc-main.id

  tags = {
    Name = "spring4shell-dev-main-internet-gw"
  }
}


# route tables
resource "aws_route_table" "spring4shell-dev-main-route_table" {
  vpc_id = aws_vpc.spring4shell-dev-vpc-main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.spring4shell-dev-main-internet-gw.id
  }

  tags = {
    Name = "spring4shellmain"
  }
}

resource "aws_route" "spring4shell-dev-main-route" {
  route_table_id            = aws_route_table.spring4shell-dev-main-route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.spring4shell-dev-main-internet-gw.id
}

# route associations public
resource "aws_route_table_association" "spring4shell-dev-main-public-attach" {
  subnet_id      = aws_subnet.spring4shell-dev-main-public.id
  route_table_id = aws_route_table.spring4shell-dev-main-route_table.id
}

resource "aws_route_table_association" "spring4shell-dev-main-public-attach-2" {
  subnet_id      = aws_subnet.spring4shell-dev-main-public-2.id
  route_table_id = aws_route_table.spring4shell-dev-main-route_table.id
}

resource "aws_route_table_association" "spring4shell-dev-main-public-attach-3" {
  subnet_id      = aws_subnet.spring4shell-dev-main-public-3.id
  route_table_id = aws_route_table.spring4shell-dev-main-route_table.id
}

# Public Network Acl
resource "aws_network_acl" "spring4shell-dev-main-acl" {
  vpc_id = aws_vpc.spring4shell-dev-vpc-main.id
  subnet_ids = [aws_subnet.spring4shell-dev-main-public.id]

  egress {
    protocol   = "tcp"
    rule_no    = 2000
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 2000
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "spring4shellNetworkAcl"
  }
}