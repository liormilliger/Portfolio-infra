# Credentials for EBS-CSI-DRIVER

data "aws_secretsmanager_secret" "aws-credentials" {
  arn = "arn:aws:secretsmanager:us-east-1:644435390668:secret:aws-secret-qXOtRS"
}

data "aws_secretsmanager_secret_version" "ebs-csi-secret" {
  secret_id = data.aws_secretsmanager_secret.aws-credentials.id
}

resource "kubernetes_secret" "csi_secret" {
  metadata {
    name = "aws-secret"
  }

  data = {
    key = data.aws_secretsmanager_secret_version.ebs-csi-secret.id
  }
}

# resource "kubernetes_secret" "csi_secret" {
#   metadata {
#     name = "aws-secret"
#   }

#   data = {
#     key = data.aws_secretsmanager_secret_version[var.secrets["aws-credentials"]].id
#   }
# }
# Credentials for my Config-Repo

data "aws_secretsmanager_secret" "config_repo_secret" {
  arn = "arn:aws:secretsmanager:us-east-1:644435390668:secret:Portfolio-Config-Repo-aNsSMy"
}

data "aws_secretsmanager_secret_version" "config_repo_secret_current" {
  secret_id = data.aws_secretsmanager_secret.config_repo_secret.id
}

# data "aws_secretsmanager_secret" "secrets" {
#   for_each = var.secrets
#   arn      = each.value
# }

# data "aws_secretsmanager_secret_version" "secret_versions" {
#   for_each  = data.aws_secretsmanager_secret.secrets
#   secret_id = each.value.id
# }

