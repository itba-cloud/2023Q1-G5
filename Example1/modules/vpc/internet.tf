resource "aws_internet_gateway" "tp3" {
  vpc_id = aws_vpc.tp3.id
  tags = {
    Name = var.igw_name
  }
}