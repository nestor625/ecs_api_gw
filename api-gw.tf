resource "aws_apigatewayv2_api" "main" {
  name          = "${var.project_name}-${var.tag_env}-api"
  protocol_type = "HTTP"

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  } 
}


resource "aws_apigatewayv2_stage" "example" {
    api_id    = aws_apigatewayv2_api.main.id
    name      = "ecs-stage"
  auto_deploy = true
}


resource "aws_apigatewayv2_vpc_link" "main" {
  name               = "${var.project_name}-${var.tag_env}-vpc-link"
  security_group_ids = [aws_security_group.ecs.id]
  
  subnet_ids         = [aws_subnet.private_ecs.0.id, aws_subnet.private_ecs.1.id]

  tags = {
    Proj = "${var.tag_proj}"
    env  = "${var.tag_env}"
  }
}


resource "aws_apigatewayv2_route" "main" {
  api_id    = aws_apigatewayv2_api.main.id
  route_key = "ANY /"
  target = "integrations/${aws_apigatewayv2_integration.ecs.id}"
}


resource "aws_apigatewayv2_integration" "ecs" {
  api_id           = aws_apigatewayv2_api.main.id
  integration_type = "HTTP_PROXY"
  integration_uri  = aws_alb_listener.front_end.arn

  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = aws_apigatewayv2_vpc_link.main.id

}