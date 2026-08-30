output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID da sub-rede publica"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID da sub-rede privada"
  value       = aws_subnet.private.id
}

output "vpc_endpoints_security_group_id" {
  description = "ID do Security Group usado pelos Interface Endpoints"
  value       = aws_security_group.vpc_endpoints.id
}
