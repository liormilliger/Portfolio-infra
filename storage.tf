resource "aws_ebs_volume" "Jenkins-Volume" {
  availability_zone = "us-east-1a"
  size              = 30  # Size in GiBs
  type              = "gp3"  # General purpose SSD
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "Jenkins-Volume"
  }
}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.Jenkins-Volume.id
  instance_id = aws_instance.my-tf-machine.id
}

# module "ecr" {
#   source = "terraform-aws-modules/ecr/aws"

#   repository_name = "liorm-portfolio"
#   repository_image_scan_on_push=false
#   # arn:aws:ecr:us-east-1:644435390668:repository/liorm-portfolio
#   # tf import module.ecr.aws_ecr_repository.this arn:aws:ecr:us-east-1:644435390668:repository/liorm-portfolio
#   #   repository_read_write_access_arns = ["arn:aws:iam::644435390668:role/liorm-portfolio-roles"]
#   #   repository_lifecycle_policy = jsonencode({
#   #     rules = [
#   #       {
#   #         rulePriority = 1,
#   #         description  = "Keep last 30 images",
#   #         selection = {
#   #           tagStatus     = "tagged",
#   #           tagPrefixList = ["v"],
#   #           countType     = "imageCountMoreThan",
#   #           countNumber   = 30
#   #         },
#   #         action = {
#   #           type = "expire"
#   #         }
#   #       }
#   #     ]
#   #   })

#   #   tags = {
#   #     Terraform   = "true"
#   #     Environment = "dev"
#   #   }
# }