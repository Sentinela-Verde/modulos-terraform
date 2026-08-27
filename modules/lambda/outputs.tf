output "function_arn" {
  description = "ARN da funcao Lambda"
  value       = aws_lambda_function.this.arn
}

output "function_name" {
  description = "Nome da funcao Lambda"
  value       = aws_lambda_function.this.function_name
}
