resource "helm_release" "argocd" {
  name = "argocd"
  namespace = "argocd"
  create_namespace = true
  wait = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  set {
    name  = "configs.repositories[0].url"
    value = "git@github.com:liormilliger/Portfolio-config.git"
  }

  set {
    name  = "configs.repositories[0].sshPrivateKeySecret.name"
    value = "config-repo-ssh"
  }

  set {
    name  = "configs.repositories[0].sshPrivateKeySecret.key"
    value = "sshPrivateKey"
  }

}

resource "helm_release" "csi-driver" {
  name = "aws-ebs-csi-driver"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
}