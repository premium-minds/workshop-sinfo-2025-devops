locals {
  ubuntu_ami = "ami-09a9858973b288bdd" # Ubuntu 24.04 Server AMI
}


resource "aws_instance" "this" {
  ami           = local.ubuntu_ami
  instance_type = "t3.nano"

  vpc_security_group_ids = []

  user_data_base64 = filebase64("${path.module}/cloud-config.yaml")

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name = "sinfo-workshop-16"
  }
}

resource "aws_security_group" "allow_traffic" {
  name        = "allow_traffic-ws-sinfo-16"
  description = "Allow HTTP and SSH inbound traffic and all outbound traffic"
  vpc_id      = "vpc-03b4b4411526cdd9c"

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group_rule" "allow_http_ingress" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_traffic.id
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_traffic.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_traffic.id
}
