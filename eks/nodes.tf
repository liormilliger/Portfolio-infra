# Creating IAM Role for Nodes

resource "aws_iam_role" "nodes" {
  name = "eks-node-group-liorm-nodes"

  assume_role_policy = jsonencode({
  
    Statement: [{
      Action = "sts:AssumeRole"
      Effect: "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version: "2012-10-17"
  })
}

# Assuming Policies for Nodes

resource "aws_iam_role_policy_attachment" "nodes-AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

# Creating Node Group
resource "aws_eks_node_group" "cluster-nodes" {
  cluster_name    = aws_eks_cluster.blog-app.name
  node_group_name = "public-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    var.subnet1,
    var.subnet2,
    var.subnet3
  ]

  capacity_type  = var.node-capacity
  instance_types = var.node-type

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Owner           = "liorm"
    bootcamp        = "19"
    expiration_date = "01-01-2028"
  }

  # taint {
  #   key    = "team"
  #   value  = "devops"
  #   effect = "NO_SCHEDULE"
  # }

  launch_template {
    name    = aws_launch_template.naming-nodes.name
    version = aws_launch_template.naming-nodes.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# Naming Nodes
resource "aws_launch_template" "naming-nodes" {
  name = "naming-nodes"
  
  tag_specifications {
    resource_type = "instance"
    
    tags = {
      Name = var.nodes-name
      Owner = "liorm"
      bootcamp = "19"
      expiration_date = "01-01-2028"
    }
  }
}