resource "aws_vpc_endpoint" "ecs_s3_service" {
  vpc_id            = aws_vpc.main.id
  service_name      = var.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ecs.id
  ]
  
  subnet_ids          = [aws_subnet.private_ecs.0.id, aws_subnet.private_ecs.1.id]
  private_dns_enabled = false
}