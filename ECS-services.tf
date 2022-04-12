resource "aws_ecs_service" "myapp-service" {
  name            = "myapp"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.myapp-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.ecs-service-role.arn
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "myapp"
    container_port   = var.coter_port
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}