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

# Credentials for my Config-Repo

data "aws_secretsmanager_secret" "config_repo_secret" {
  arn = "arn:aws:secretsmanager:us-east-1:644435390668:secret:Portfolio-Config-Repo-aNsSMy"
}

data "aws_secretsmanager_secret_version" "config_repo_secret_current" {
  secret_id = data.aws_secretsmanager_secret.config_repo_secret.id
}


