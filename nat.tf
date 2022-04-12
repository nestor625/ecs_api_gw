resource "aws_eip" "gw1" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_eip" "gw2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

    tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_nat_gateway" "private1" {
  allocation_id = aws_eip.gw1.id
  subnet_id     = aws_subnet.public_subnet.0.id

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "private2" {
  allocation_id = aws_eip.gw2.id
  subnet_id     = aws_subnet.public_subnet.1.id

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}