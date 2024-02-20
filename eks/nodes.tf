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

resource "aws_iam_role_policy_attachment" "nodes_policy_attachment" {
  for_each   = toset(var.IAM_policies)
  policy_arn = each.value
  role       = aws_iam_role.nodes.name
}

# Creating Node Group
resource "aws_eks_node_group" "cluster-nodes" {
  cluster_name    = aws_eks_cluster.blog-app.name
  node_group_name = "public-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = values(var.subnets)

  capacity_type  = var.node_capacity
  instance_types = var.node_type

  scaling_config {
    desired_size = var.desired
    max_size     = var.max_size
    min_size     = var.min_size
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Owner           = "liorm"
    bootcamp        = "19"
    expiration_date = "01-01-2028"
  }

  launch_template {
    name    = aws_launch_template.naming-nodes.name
    version = aws_launch_template.naming-nodes.latest_version
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes_policy_attachment
  ]
}

# Naming Nodes
resource "aws_launch_template" "naming-nodes" {
  name = "naming-nodes"
  
  tag_specifications {
    resource_type = "instance"
    
    tags = {
      Name = var.node_name
      Owner = "liorm"
      bootcamp = "19"
      expiration_date = "01-01-2028"
    }
  }
}