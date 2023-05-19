resource "aws_vpc" "tp3" {
  cidr_block = var.cidr_block
  tags = {
    name = "vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "subnet_private" {
  count             = var.zones_count
  cidr_block        = cidrsubnet("10.0.0.0/16", 8, count.index + 1)
  vpc_id            = aws_vpc.tp3.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "private_${count.index + 1}"
  }
}
resource "aws_subnet" "subnet_public" {
  count                   = var.zones_count
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + 3)
  vpc_id                  = aws_vpc.tp3.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_${count.index + 1}"
  }
}
