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

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.REGION
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}