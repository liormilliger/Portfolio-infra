# VPC

variable "REGION" {
  description = "AWS Region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type = string
}


variable "availability_zone" {
  description = "A map of availability zones to subnet IDs"
  type        = list(string)
}

variable "az_name" {
  description = "Availability Zone Name"
  type = list(string)
}

# CLUSTER

variable "cluster_name" {
  description = "cluster name"
  type        = string
}

variable "IAM_policies" {
  description = "ARNs for IAM policies of Nodes"
  type        = list(string)
}

# NODES

variable "node_type" {
  description = "instance type for nodes"
  type        = list(string)
}

variable "desired" {
  description = "desired number of nodes"
  type        = number
}

variable "min_size" {
  description = "minimum number of nodes"
  type        = number
}

variable "max_size" {
  description = "maximum number of nodes"
  type        = number
}

variable "node_capacity" {
  description = "instance usage"
  type        = string
}

variable "node_name" {
  description = "What would you call your nodes?"
  type        = string
}

# REPOSITORY

variable "config-repo-secret-name" {
  description = "Your k8s repository ssh name"
  type        = string
}

variable "config-repo-url" {
  description = "Your k8s repository ssh url"
  type        = string
}

# AWS

variable "ACCOUNT_ID" {
  description = "AWS Account ID"
  type = string
}
