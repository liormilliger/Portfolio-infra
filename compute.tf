resource "aws_key_pair" "liorm_key" {
  key_name   = "jenkins2024-key"
  public_key = file("~/.ssh/liorm-portfolio-key.pub")
}

resource "aws_instance" "my-tf-machine" {
  ami                    = "ami-01c115fd0ea0ea9a2"
  instance_type          = "t3a.large"
  key_name               = aws_key_pair.liorm_key.id
  availability_zone      = "us-east-1a"
  subnet_id              = aws_subnet.us-east-sub1.id
  vpc_security_group_ids = [aws_security_group.liorm-portfolio-SG.id]

  tags = {
    Name = "Jenkins-Server-TF"
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [ module.eks ]
  
  lifecycle {
    prevent_destroy = false
  }
}


resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata.0.name

  # version   = "4.5.2"

  depends_on = [
    kubernetes_namespace.argocd
  ]

  lifecycle {
    prevent_destroy = false
  }
}

resource "kubernetes_namespace" "nginx-controller" {
  metadata {
    name = "nginx-controller"
  }
  depends_on = [ module.eks ]
  
  lifecycle {
    prevent_destroy = false
  }
}

resource "helm_release" "Nginx-Ingress-Controller" {
  name = "nginx-ingress-controller"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace = kubernetes_namespace.nginx-controller.metadata.0.name
}