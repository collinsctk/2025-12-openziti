resource "aws_vpc" "qytang_vpc" {
  provider      = aws.aws_provider
  cidr_block    = "10.2.0.0/16"

  tags = {
    Name = "qytang_vpc"
  }
}

resource "aws_subnet" "qytang_subnet_1" {
  provider      = aws.aws_provider
  vpc_id = aws_vpc.qytang_vpc.id
  cidr_block = "10.2.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = format("%s%s", var.aws_region, "a")
  tags = {
    Name = "qytang_subnet_1"
  }
}

resource "aws_internet_gateway" "qyt_internet_gw" {
  provider      = aws.aws_provider
  vpc_id        = aws_vpc.qytang_vpc.id

  tags = {
    Name = "qyt_internet_gw"
  }
}

resource "aws_route_table" "qyt_aws_route_table" {
  provider      = aws.aws_provider
  vpc_id        = aws_vpc.qytang_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.qyt_internet_gw.id
  }

  tags = {
    Name = "qyt_aws_route_table"
  }
}

resource "aws_route_table_association" "qyt_aws_route_table_association_subnet_1" {
  provider        = aws.aws_provider
  subnet_id       = aws_subnet.qytang_subnet_1.id
  route_table_id  = aws_route_table.qyt_aws_route_table.id
}
