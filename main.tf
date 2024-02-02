module "eks" {
  source = "./eks"

  subnet1 = module.network.subnet1
  subnet2 = module.network.subnet2
  subnet3 = module.network.subnet3
  fluentd-cm = kubectl_manifest.fluentd_configmap
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