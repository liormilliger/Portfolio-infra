variable "subnet1" {
  description = "subnet id 1"
  type        = string
}

variable "subnet2" {
  description = "subnet id 2"
  type        = string
}

variable "subnet3" {
  description = "subnet id 3"
  type        = string
}

variable "cluster-name" {
  description = "cluster name"
  type        = string
  default = "blog-cluster"
}

variable "node-type" {
  description = "instance type for nodes"
  type        = list
  default = ["t3a.xlarge"]
}

variable "node-capacity" {
  description = "instance usage"
  type        = string
  default = "ON_DEMAND"
}

variable "nodes-name" {
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

variable "fluentd-cm" {
  description = "fluentd configmap"
  type = any
}
