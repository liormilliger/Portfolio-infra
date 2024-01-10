resource "aws_key_pair" "liorm_key" {
  key_name   = "jenkins2024-key"
  public_key = file("~/.ssh/liorm-portfolio-key.pub")
}
resource "aws_instance" "my-tf-machine" {
  ami                    = "ami-01c115fd0ea0ea9a2"
  instance_type          = "t3a.large"
  key_name               = aws_key_pair.liorm_key.id
  availability_zone      = "us-east-1a"
  subnet_id              = aws_subnet.us-east-sub1.id
  vpc_security_group_ids = [aws_security_group.liorm-portfolio-SG.id]

#   ebs_block_device {
    
#   }

#   root_block_device {
    
#   }


  tags = {
    Name = "my-terraform-machine"
  }
}


# resource "aws_volume_attachment" "ebs_attach" {
#   device_name = "/dev/sda1"                      # or another device name
#   volume_id   = aws_ebs_volume.Jenkins-Volume.id # Replace with your volume ID
#   instance_id = aws_instance.my-tf-machine.id
# }