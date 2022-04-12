data "template_file" "myapp-task-definition-template" {
  template = file("templates/app.json.tpl")
  vars = {
    REPOSITORY_URL = var.image
    coter_port = var.coter_port
    cpu = var.cpu
    memory = var.memory
  }
}

resource "aws_ecs_task_definition" "myapp-task-definition" {
  family                = "myapp"
  container_definitions = data.template_file.myapp-task-definition-template.rendered
}