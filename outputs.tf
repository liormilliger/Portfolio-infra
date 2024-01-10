output "VPC_ID" {
  description = "VPC id for liorm-portfolio"
  value       = aws_vpc.liorm-portfolio.id
}

output "SG" {
  description = "Security Group"
  value       = aws_security_group.liorm-portfolio-SG.id
}

output "subnets_1a" {
  description = "Subnets Availability Zones"
  value       = aws_subnet.us-east-sub1.id
}
