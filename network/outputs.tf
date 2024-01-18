output "VPC_ID" {
    description = "VPC id for liorm_portfolio"
    value = aws_vpc.liorm-portfolio.id
}

output "subnet1" {
  description = "Subnet AZ1"
  value = aws_subnet.us-east-sub1.id
}

output "subnet2" {
  description = "Subnet AZ2"
  value = aws_subnet.us-east-sub2.id
}

output "subnet3" {
  description = "Subnet AZ3"
  value = aws_subnet.us-east-sub3.id
}

output "subnet4" {
  description = "Subnet AZ4"
  value = aws_subnet.us-east-sub4.id
}