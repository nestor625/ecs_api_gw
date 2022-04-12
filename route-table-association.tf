resource "aws_route_table_association" "public_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "private_route1_table_association" {
  subnet_id      = aws_subnet.private_ecs.0.id
  route_table_id = aws_route_table.privateroute1.id
}

resource "aws_route_table_association" "private_route2_table_association" {
  subnet_id      = aws_subnet.private_ecs.1.id
  route_table_id = aws_route_table.privateroute2.id
}

resource "aws_route_table_association" "private_dbroute_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.dbsubnets.*.id, count.index)
  route_table_id = aws_route_table.dbroute.id
}

resource "aws_route_table_association" "bastion_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.bastion.*.id, count.index)
  route_table_id = aws_route_table.bastion.id
}