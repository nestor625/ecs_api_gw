# ecs.tf

resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-${var.tag_env}-ecs-cluster"

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}




# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster