# NETWORK
##########

REGION       = "us-east-1"
vpc_name = "liorm-portfolio"
availability_zone = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
]
az_name = [
    "liorm-us-east-1a",
    "liorm-us-east-1b",
    "liorm-us-east-1c"
]

# CLUSTER
##########
cluster_name = "blog-cluster"
IAM_policies = [
  "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
  "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
  "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
]

# NODES
########
node_type     = ["t3a.large"]
desired       = 3
min_size      = 1
max_size      = 4
node_capacity = "ON_DEMAND"
node_name     = "liorm-nodes"

# REPO
#######
config-repo-secret-name = "config-repo-ssh"
config-repo-url         = "git@github.com:liormilliger/Portfolio-config.git"

