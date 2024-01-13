terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.0"
    }
  }

  backend "s3" {
    bucket = "liorm-portfolio-tfstate-s3"
    key    = "data/terraform.tfstate"
    region = "us-east-1"

    # dynamodb_table = "liorm-lockstate"
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}
# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_name
# }

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token

  # exec {
  #   api_version = "client.authentication.k8s.io/v1alpha1"
  #   command     = "aws"
  #   args = ["eks", "--region", "us-east-1", "update-kubeconfig", "--name", "blog-cluster"]
  # }
}

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"

  default_tags {
    tags = {
      Owner           = "liorm"
      bootcamp        = "19"
      expiration_date = "01-01-2028"
    }
  }
}