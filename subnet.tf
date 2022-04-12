data "aws_availability_zones" "available" {
}

resource "aws_subnet" "public_subnet" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.tag_env}/Public"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_subnet" "private_ecs" {
  count             = var.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.tag_env}/ECSPrivate"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.main.id
  cidr_block           = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 4)
  availability_zone    = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.tag_env}/DBPrivate"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_subnet" "bastion" {
  count                = var.az_count
  vpc_id               = aws_vpc.main.id
  cidr_block           = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index + 6)
  availability_zone    = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.tag_env}/Bastion"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}