resource "aws_vpc" "liorm-portfolio" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "liorm-portfolio"
  }
}

resource "aws_subnet" "us-east-sub1" {
  vpc_id                  = aws_vpc.liorm-portfolio.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "liorm-us-east-sub1"
  }
}

resource "aws_internet_gateway" "liorm" {
  vpc_id = aws_vpc.liorm-portfolio.id
  tags = {
    Name = "liorm-portfolio"
  }
}


resource "aws_route_table" "liorm" {
  vpc_id = aws_vpc.liorm-portfolio.id

  tags = {
    Name = "liorm-portfolio"
  }
}


resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.liorm.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.liorm.id
}

resource "aws_route_table_association" "liorm-pub-1a" {
  subnet_id      = aws_subnet.us-east-sub1.id
  route_table_id = aws_route_table.liorm.id
}

resource "aws_security_group" "liorm-portfolio-SG" {
  name        = "liorm-SG"
  description = "Allow incoming HTTP traffic from your IP"
  vpc_id      = aws_vpc.liorm-portfolio.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # cidr_blocks = ["${var.KARMI_IP}", "${var.HOME_IP}", "${var.Develeap_IP}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}