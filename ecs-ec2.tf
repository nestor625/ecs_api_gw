resource "aws_launch_configuration" "ecs-example-launchconfig" {
  name_prefix          = "${var.tag_proj}-${var.tag_env}-ecs-launchconfig"
  image_id             = var.ECS_AMIS[var.region]
  instance_type        = var.ECS_INSTANCE_TYPE
  iam_instance_profile = aws_iam_instance_profile.ecs-ec2-role.id
  security_groups      = [aws_security_group.ecs.id]
  key_name             = var.keypair_name_ec2
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=${var.project_name}-${var.tag_env}-ecs-cluster' > /etc/ecs/ecs.config\nstart ecs"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-example-autoscaling" {
  name                 = "${var.tag_proj}-${var.tag_env}-ecs-autoscaling"
  vpc_zone_identifier  = [aws_subnet.private_ecs.0.id, aws_subnet.private_ecs.1.id]
  launch_configuration = aws_launch_configuration.ecs-example-launchconfig.name
  min_size             = 1
  max_size             = 1
  target_group_arns    = [aws_alb_target_group.app.arn]

  tag {
    key                 = "Name"
    value               = "${var.tag_proj}-${var.tag_env}-ecs-ec2-container"
    propagate_at_launch = true
  }
}