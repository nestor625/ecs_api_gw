resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}
