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
    cidr_blocks = ["${var.KARMI_IP}", "${var.HOME_IP}", "${var.Develeap_IP}"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8100
    protocol    = "tcp"
    cidr_blocks = ["${var.KARMI_IP}", "${var.HOME_IP}", "${var.Develeap_IP}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}