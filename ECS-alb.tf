resource "aws_alb" "myapp-alb" {
  name            = "${var.project_name}-${var.tag_env}-myapp-alb"
  subnets         = [aws_subnet.private_ecs.0.id, aws_subnet.private_ecs.1.id]
  security_groups = [aws_security_group.lbsg.id]
  internal        = true

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

resource "aws_alb_target_group" "app" {
  name        = "${var.project_name}-${var.tag_env}-myapp-target-group"
  port        = var.coter_port
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.myapp-alb.id
  port              = var.coter_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id

    type = "forward"
  }
  
  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}