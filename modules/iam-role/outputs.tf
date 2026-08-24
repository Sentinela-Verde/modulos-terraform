output "role_arn" {
  description = "ARN da Role criada"
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "Nome da Role criada"
  value       = aws_iam_role.this.name
}
