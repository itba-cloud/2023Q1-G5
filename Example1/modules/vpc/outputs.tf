output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.tp3.id
}
output "vpc_cidr" {
  description = "VPC CIDR"
  value       = aws_vpc.tp3.cidr_block
}

output "private_subnets_ids" {
  value = [
    for k, v in aws_subnet.subnet_private : v.id
  ]
}