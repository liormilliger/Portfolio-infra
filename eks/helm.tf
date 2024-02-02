#Installing Helm Releases for ArgoCD and CSI-Driver

resource "helm_release" "argocd" {
  name = "argocd"
  namespace = "argocd"
  create_namespace = true
  wait = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  depends_on = [ var.fluentd-cm ]
}

resource "kubernetes_namespace" "fluentd" {
  metadata {
  name = "fluentd"
  }

}

resource "helm_release" "csi-driver" {
  name = "aws-ebs-csi-driver"
  namespace = "kube-system"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  depends_on = [ kubernetes_secret.csi_secret ]
}