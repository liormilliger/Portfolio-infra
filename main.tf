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
    config_path            = "~/.kube/config"
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

data "aws_iam_role" "eks_service_role" {
  name = "AWSServiceRoleForAmazonEKS"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "blog-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  vpc_id     = module.network.VPC_ID
  subnet_ids = [module.network.subnet1, module.network.subnet2, module.network.subnet3, module.network.subnet4]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.large", "t3.large"]
  }

  eks_managed_node_groups = {
    TF-Machines = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3a.large"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Owner           = "liorm"
    bootcamp        = "19"
    expiration_date = "01-01-2028"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  # depends_on = [ module.eks ]

  # lifecycle {
  #   prevent_destroy = false
  # }
}


resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata.0.name

  # version   = "4.5.2"
  # depends_on and lifecycle might need hashing when destroying cluster
  
  # values = [
  #   file("${path.module}/nginx-values.yaml")
  # ]
  
  # depends_on = [
  #   kubernetes_namespace.argocd
  # ]

  # lifecycle {
  #   prevent_destroy = false
  # }
}

resource "kubernetes_namespace" "nginx-controller" {
  metadata {
    name = "nginx-controller"
  }
  # # depends_on and lifecycle might need hashing when destroying cluster
  # depends_on = [ module.eks ]

  # lifecycle {
  #   prevent_destroy = false
  # }
}

resource "helm_release" "Nginx-Ingress-Controller" {
  name = "nginx-ingress-controller"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.nginx-controller.metadata.0.name

  # depends_on = [
  #   kubernetes_namespace.nginx-controller
  # ]

  # lifecycle {
  #   prevent_destroy = false
  # }
}

module "network" {
  source = "./network"
}

module "compute" {
  source = "./compute"

#   vpc     = module.network.VPC_ID
#   subnet1 = module.network.subnet1
#   subnet2 = module.network.subnet2
#   subnet3 = module.network.subnet3
#   subnet4 = module.network.subnet4
}

module "security" {
  source = "./security"

  vpc = module.network.VPC_ID
}