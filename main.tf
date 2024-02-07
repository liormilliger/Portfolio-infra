module "eks" {
  source = "./eks"

  subnets = module.network.subnet_ids
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