variable "IAM_policies" {
  description = "ARNs for IAM policies of Nodes"
  type = list(string)
  default = [ 
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ]
}

variable "subnets" {
  description = "A map of availability zones to subnet IDs"
  type        = map(string)
}

# variable "secrets" {
#   description = "Map of secret names to their ARNs"
#   type        = map(string)
#   default     = {
#     "aws-credentials"       = "arn:aws:secretsmanager:us-east-1:644435390668:secret:aws-secret-qXOtRS",
#     "config_repo_secret"    = "arn:aws:secretsmanager:us-east-1:644435390668:secret:Portfolio-Config-Repo-aNsSMy"
#   }
# }

variable "cluster_name" {
  description = "cluster name"
  type        = string
  default = "blog-cluster"
}

# Nodes Variables

variable "node_type" {
  description = "instance type for nodes"
  type        = list(string)
  default = ["t3a.xlarge"]
}

variable "desired" {
  description = "desired number of nodes"
  type = number
  default = 3
}

variable "min_size" {
  description = "minimum number of nodes"
  type = number
  default = 1
}

variable "max_size" {
  description = "maximum number of nodes"
  type = number
  default = 4
}

variable "node_capacity" {
  description = "instance usage"
  type        = string
  default = "ON_DEMAND"
}

variable "node_name" {
  description = "What would you call your nodes?"
  type        = string
  default = "liorm-nodes"
}

variable "config-repo-secret-name" {
  description = "Your k8s repository ssh name"
  type        = string
  default = "config-repo-ssh"
}

variable "config-repo-url" {
  description = "Your k8s repository ssh url"
  type = string
  default = "git@github.com:liormilliger/Portfolio-config.git"
}

# variable "fluentd-cm" {
#   description = "fluentd configmap"
#   type = any
# }
