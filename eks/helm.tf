resource "helm_release" "argocd" {
  name = "argocd"
  namespace = "argocd"
  create_namespace = true
  wait = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

}

# resource "argocd_application" "config_repo_app" {
#   depends_on = [kubernetes_secret.config_repo_ssh]

#   metadata {
#     name      = "portfolio-config"
#     namespace = "argocd"
#   }

#   spec {
#     project = "default"

#     source {
#       repo_url        = "git@github.com:liormilliger/Portfolio-config.git"
#       path            = "app-of-apps"
#       target_revision = "main"
#       ssh_private_key_secret {
#         name = kubernetes_secret.config_repo_ssh.metadata.0.name
#         key  = "sshPrivateKey"
#       }
#     }

#     destination {
#       server    = "https://kubernetes.default.svc"
#       namespace = "argocd"
#     }

#     sync_policy {
#       automated {
#         prune      = true
#         self_heal  = true
#       }
#     }
#   }
# }

resource "helm_release" "csi-driver" {
  name = "aws-ebs-csi-driver"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
}