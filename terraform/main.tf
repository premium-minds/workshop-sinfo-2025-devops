locals {
  ubuntu_ami = "ami-09a9858973b288bdd" # Ubuntu 24.04 Server AMI
}


resource "aws_instance" "this" {
  ami           = local.ubuntu_ami
  instance_type = "t3.micro"

  vpc_security_group_ids = []

  user_data_base64 = filebase64("${path.module}/cloud-config.yaml")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name = "sinfo-workshop-16"
  }
}
