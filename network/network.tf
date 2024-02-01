resource "aws_vpc" "liorm-portfolio" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_subnet" "us-east-sub1" {
  vpc_id                  = aws_vpc.liorm-portfolio.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[0]
  tags = {
    Name = var.az_name[0]
  }
}

resource "aws_subnet" "us-east-sub2" {
  vpc_id                  = aws_vpc.liorm-portfolio.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[1]
  tags = {
    Name = var.az_name[1]
  }
}

resource "aws_subnet" "us-east-sub3" {
  vpc_id                  = aws_vpc.liorm-portfolio.id
  cidr_block              = "10.1.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[2]
  tags = {
    Name = var.az_name[2]
  }
}

resource "aws_internet_gateway" "liorm" {
  vpc_id = aws_vpc.liorm-portfolio.id
  tags = {
    Name = var.vpc-name
  }
}


resource "aws_route_table" "liorm" {
  vpc_id = aws_vpc.liorm-portfolio.id

  tags = {
    Name = var.vpc-name
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.liorm.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.liorm.id
}

resource "aws_route_table_association" "liorm-pub-1" {
  subnet_id      = aws_subnet.us-east-sub1.id
  route_table_id = aws_route_table.liorm.id
}

resource "aws_route_table_association" "liorm-pub-2" {
  subnet_id      = aws_subnet.us-east-sub2.id
  route_table_id = aws_route_table.liorm.id
}

resource "aws_route_table_association" "liorm-pub-3" {
  subnet_id      = aws_subnet.us-east-sub3.id
  route_table_id = aws_route_table.liorm.id
}
