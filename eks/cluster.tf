# Creating IAM Role for Cluster
resource "aws_iam_role" "liorm-portfolio" {
  name = "eks-cluster-liorm-portfolio"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Assuming EKS Cluster Policy for Cluster Role
resource "aws_iam_role_policy_attachment" "liorm-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.liorm-portfolio.name
}

# Creating the Cluster
resource "aws_eks_cluster" "blog-app" {
  name = var.cluster-name
  role_arn = aws_iam_role.liorm-portfolio.arn

  vpc_config {
    subnet_ids = [
      var.subnet1,
      var.subnet2,
      var.subnet3
    ]
  }
  depends_on = [aws_iam_role_policy_attachment.liorm-AmazonEKSClusterPolicy]
}
