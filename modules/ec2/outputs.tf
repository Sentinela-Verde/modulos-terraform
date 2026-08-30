output "instance_id" {
  description = "ID da instancia EC2"
  value       = aws_instance.this.id
}

output "private_ip" {
  description = "IP privado da instancia"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "IP publico da instancia (vazio se associate_public_ip = false)"
  value       = aws_instance.this.public_ip
}
