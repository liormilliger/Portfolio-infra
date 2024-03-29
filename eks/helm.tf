#Installing and Configuring ArgoCD

resource "helm_release" "argocd" {
  name = "argocd"
  namespace = "argocd"
  create_namespace = true
  wait = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version = "5.53.12"
}

resource "kubernetes_secret" "config_repo_ssh" {
  depends_on = [helm_release.argocd]

  metadata {
    name      = var.config-repo-secret-name
    namespace = "argocd"

    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    name          = var.config-repo-secret-name
    type          = "git"
    url           = var.config-repo-url
    sshPrivateKey = data.aws_secretsmanager_secret_version.config_repo_secret_current.secret_string
  }
}

# CSI Driver Release
resource "helm_release" "csi-driver" {
  name = "aws-ebs-csi-driver"
  namespace = "kube-system"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  depends_on = [ kubernetes_secret.csi_secret ]
}
