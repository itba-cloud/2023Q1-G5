resource "aws_nat_gateway" "nat" {
  for_each  = var.subnet
  subnet_id = each.value.id
  # subnet_id     = element(values(aws_subnet.subnet_public), each.value).id
  depends_on = [aws_internet_gateway.tp3, aws_subnet.subnet_public]
}
