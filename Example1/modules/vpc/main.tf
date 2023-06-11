resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    name = "vpc"
  }
}


resource "aws_subnet" "subnet_private" {
  count             = var.zones_count
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + 1)
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  #deberia funcionar pq llama a la pagina datasources y busca el nom bre availability_zones que se llama available y de ahi el nombre

  tags = {
    Name = "private_${count.index + 1}"
  }
}
resource "aws_subnet" "subnet_public" {
  count                   = var.zones_count
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 3)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_${count.index + 1}"
  }
}
