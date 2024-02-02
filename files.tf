resource "kubectl_manifest" "storage_class_csi" {
  yaml_body = file("${path.module}/files/storage-class-csi.yaml")
}

resource "kubectl_manifest" "service_monitor" {
  yaml_body = file("${path.module}/files/prometheus-service-monitor.yaml")
  depends_on = [ module.eks.argocd_helm ]
}


resource "kubectl_manifest" "fluentd_configmap" {
  yaml_body = file("${path.module}/files/fluentd-cm-GPT.yaml")
  depends_on = [ module.eks.argocd_helm ]
}

