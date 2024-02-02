# Outputs to use as Vars

output "cluster_name" {
    description = "name of cluster"
    value = aws_eks_cluster.blog-app.name
}

output "cluster_endpoint" {
    description = "cluster endpoint"
    value = aws_eks_cluster.blog-app.endpoint
}

output "cluster_ca" {
    description = "cluster ca data"
    value = aws_eks_cluster.blog-app.certificate_authority[0].data
}

output "argocd_helm" {
    description = "ArgoCD Helm Release"
    value = helm_release.argocd
}

output "config_repo_sync" {
    description = "Syncing Config-Repo with ArgoCD"
    value = kubernetes_secret.config_repo_ssh
}

output "fluentd_ns" {
    description = "creating fluentd namespace"
    value = kubernetes_namespace.fluentd
}

# output "config_repo_cred" {
#     description = "config repo ssh key"
#     value = argocd_repository_credentials.private.ssh_private_key
# }

