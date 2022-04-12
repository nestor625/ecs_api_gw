resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}-vpc"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}