resource "aws_sns_topic" "sns_topic" {
  name            = "${var.project_name}-${var.tag_env}-topic"

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}