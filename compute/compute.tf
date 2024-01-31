resource "aws_key_pair" "liorm_key" {
  key_name   = "jenkins2024-key"
  public_key = file("~/.ssh/liorm-portfolio-key.pub")
}

# # Jenkins instance with ami from snapshot
# resource "aws_instance" "Jenkins-tf" {
#   ami                    = "ami-08502f17193d65b52"
#   # ami-25                    = "ami-01c115fd0ea0ea9a2"
#   instance_type          = "t3a.large"
#   key_name               = aws_key_pair.liorm_key.id
#   availability_zone      = "us-east-1a"
#   subnet_id              = aws_subnet.us-east-sub1.id
#   vpc_security_group_ids = [aws_security_group.liorm-portfolio-SG.id]
  
#   # ebs_block_device {
#   #   device_name = "Jenkins-Volume"
#   #   snapshot_id = "snap-091ad9e7cd4cb0736"
#   # }

#   tags = {
#     Name = "Jenkins-Server-TF"
#   }
# }


