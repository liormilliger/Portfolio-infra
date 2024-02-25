variable "IAM_policies" {
  description = "ARNs for IAM policies of Nodes"
  type = list(string)
}

variable "subnets" {
  description = "A map of availability zones to subnet IDs"
  type        = map(string)
}

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

# Nodes Variables

variable "node_type" {
  description = "instance type for nodes"
  type        = list(string)
}

variable "desired" {
  description = "desired number of nodes"
  type = number
}

variable "min_size" {
  description = "minimum number of nodes"
  type = number
}

variable "max_size" {
  description = "maximum number of nodes"
  type = number
}

variable "node_capacity" {
  description = "instance usage"
  type        = string
}

variable "node_name" {
  description = "What would you call your nodes?"
  type        = string
}

variable "config-repo-secret-name" {
  description = "Your k8s repository ssh name"
  type        = string
}

variable "config-repo-url" {
  description = "Your k8s repository ssh url"
  type = string
}

## SECRETS

variable "ACCOUNT_ID" {
  description = "AWS Account ID"
  type = string
}

variable "REGION" {
  description = "AWS Region"
  type = string
}

variable "AWS_SECRET_NAME" {
  description = "AWS secret name for"
  type = string
}

variable "CONFIG_REPO_SECRET_NAME" {
  description = "secret for config repo"
  type = string
}

