module "eks" {
  source = "./eks"

  subnet1 = module.network.subnet1
  subnet2 = module.network.subnet2
  subnet3 = module.network.subnet3
  subnet4 = module.network.subnet4
}

module "network" {
  source = "./network"
}

# module "compute" {
#   source = "./compute"
# }

# module "security" {
#   source = "./security"

#   vpc = module.network.VPC_ID
# }