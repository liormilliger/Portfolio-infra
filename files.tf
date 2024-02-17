resource "kubectl_manifest" "storage_class_csi" {
  yaml_body = file("${path.module}/files/storage-class-csi.yaml")
}

resource "kubectl_manifest" "argo_cd_apps" {
  yaml_body  = file("${path.module}/files/app-of-apps.yaml")
  depends_on = [ module.eks.argocd_helm ]
}

