data "aws_iam_role" "eks_service_role" {
  name = "AWSServiceRoleForAmazonEKS"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "blog-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  #   create_iam_role = false
  #   iam_role_arn = data.aws_iam_role.eks_service_role.arn

  vpc_id     = aws_vpc.liorm-portfolio.id
  subnet_ids = [aws_subnet.us-east-sub1.id, aws_subnet.us-east-sub2.id, aws_subnet.us-east-sub3.id, aws_subnet.us-east-sub4.id]

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3a.large", "t3.large"]
  }

  eks_managed_node_groups = {
    TF-Machines = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3a.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Owner           = "liorm"
    bootcamp        = "19"
    expiration_date = "01-01-2028"
  }
}

