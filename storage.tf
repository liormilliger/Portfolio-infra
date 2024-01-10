# resource "aws_ebs_volume" "Jenkins-Volume" {
#   availability_zone = "us-east-1a"
#   size              = 20
# #   snapshot_id = "snap-098deebfc51135bc0"
#   type = "standard"
#   tags = {
#     Name = "Jenkins-Volume"
#   }
# }

# resource "aws_ebs_snapshot" "Jenkins-Volume" {
#   volume_id = aws_ebs_volume.Jenkins-Volume.id

#   #   tags = {
#   #     Name = ""
#   #   }
# }

# import {
#   to = aws_ebs_snapshot.Jenkins-Volume
#   id = "snap-098deebfc51135bc0"
# # USE COMMAND: tf import aws_ebs_snapshot.Jenkins-Volume snap-098deebfc51135bc0
# }