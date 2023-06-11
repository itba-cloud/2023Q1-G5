resource "aws_nat_gateway" "main" {
  for_each  = var.subnet
  subnet_id = each.value.id
  depends_on = [aws_internet_gateway.tp3, aws_subnet.subnet_public]
}
