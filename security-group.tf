resource "aws_security_group" "rds" {
  name        = "${var.tag_proj}-${var.tag_env}-database"
  description = "controls access to the rds"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  ingress {
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}-database"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}


resource "aws_security_group" "lbsg" {
  name        = "${var.tag_proj}-${var.tag_env}-alb"
  description = "controls access to the alb"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.coter_port
    to_port     = var.coter_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}-ecs-alb"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}


resource "aws_security_group" "ecs" {
  name        = "${var.tag_proj}-${var.tag_env}-ecs"
  description = "controls access to the ecs"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port       = var.coter_port
    to_port         = var.coter_port
    protocol        = "tcp"
    security_groups = [aws_security_group.lbsg.id]
  }

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}-ecs"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}


resource "aws_security_group" "bastion" {
  name        = "${var.tag_proj}-${var.tag_env}-bastion-host"
  description = "controls access to the bastion"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_proj}-${var.tag_env}-bastion-host"
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}