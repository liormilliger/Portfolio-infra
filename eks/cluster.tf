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

# Securing Connection between K8S and AWS

data "tls_certificate" "eks" {
  url = aws_eks_cluster.blog-app.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.blog-app.identity[0].oidc[0].issuer
}
