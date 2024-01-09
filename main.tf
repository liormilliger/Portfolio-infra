module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19"

  cluster_name                   = blog-app
  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }
}
#  iam_role_additional_policies = {
#    additional = aws_iam_policy.additional.arn
#  }

#  vpc_id                   = module.vpc.vpc_id
#  subnet_ids               = module.vpc.private_subnets
#  control_plane_subnet_ids = module.vpc.intra_subnets

  # Extend cluster security group rules
  cluster_security_group_additional_rules = {
 
    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    # Test: https://github.com/terraform-aws-modules/terraform-aws-eks/pull/2319
    ingress_source_security_group_id = {
      description              = "Ingress from another computed security group"
      protocol                 = "tcp"
      from_port                = 22
      to_port                  = 22
      type                     = "ingress"
      source_security_group_id = aws_security_group.additional.id
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20231207"
    instance_types = ["t3a.large"]

    attach_cluster_primary_security_group = true
#    vpc_security_group_ids                = [aws_security_group.additional.id]
#    iam_role_additional_policies = {
#      additional = aws_iam_policy.additional.arn
#    }
  }

  eks_managed_node_groups = {
    green = {
      min_size     = 2
      max_size     = 3
      desired_size = 3

      instance_types = ["t3a.small"]
      capacity_type  = "ON_DEMAND"
      labels = {
        owner = "liorm"
        bootcamp  = "19"
        expiration_date   = "01-01-2028"
      }
      
      tags = {
        ExtraTag = "launched"
      }
    }
  }

# Create a new cluster where both an identity provider and Fargate profile is created
  # will result in conflicts since only one can take place at a time
  # # OIDC Identity provider
  # cluster_identity_providers = {
  #   sts = {
  #     client_id = "sts.amazonaws.com"
  #   }
  # }

  # aws-auth configmap
  # manage_aws_auth_configmap = true
  
  #tags = local.tags
# }