module "eks" {
  source = "./eks"

  subnets = module.network.subnet_ids
}

module "network" {
  source = "./network"
}

module "files" {
  source = "./files"
}
# module "compute" {
#   source = "./compute"
# }

# module "security" {
#   source = "./security"

#   vpc = module.network.VPC_ID
# }