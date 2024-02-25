module "network" {
  source = "./network"
  availability_zone = var.availability_zone
  vpc_name = var.vpc_name
  az_name = var.az_name

}

module "eks" {
  source = "./eks"

  subnets                 = module.network.subnet_ids
  cluster_name            = var.cluster_name
  IAM_policies            = var.IAM_policies
  node_type               = var.node_type
  desired                 = var.desired
  min_size                = var.min_size
  max_size                = var.max_size
  node_capacity           = var.node_capacity
  node_name               = var.node_name
  config-repo-secret-name = var.config-repo-secret-name
  config-repo-url         = var.config-repo-url
  ACCOUNT_ID = var.ACCOUNT_ID
  REGION = var.REGION
}

