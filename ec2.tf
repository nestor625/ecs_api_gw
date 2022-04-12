resource "aws_instance" "app_server" {
  ami                    = var.ubuntu[var.region]
  instance_type          = var.ubuntu_INSTANCE_TYPE
  subnet_id              = aws_subnet.public_subnet.1.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = var.keypair_name_ec2

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
}
