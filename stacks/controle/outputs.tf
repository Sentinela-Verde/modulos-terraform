output "instance_id" {
  description = "ID da instancia EC2 de controle"
  value       = module.controle.instance_id
}

output "public_ip" {
  description = "IP publico da instancia de controle"
  value       = module.controle.public_ip
}

output "mlflow_bucket_name" {
  description = "Nome do bucket S3 usado como artifact store do MLflow"
  value       = module.mlflow_bucket.bucket_id
}

output "security_group_id" {
  description = "ID do Security Group da instancia de controle"
  value       = aws_security_group.controle.id
}
