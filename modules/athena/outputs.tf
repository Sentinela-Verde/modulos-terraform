output "workgroup_name" {
  description = "Nome do Athena Workgroup"
  value       = aws_athena_workgroup.this.name
}

output "workgroup_arn" {
  description = "ARN do Athena Workgroup"
  value       = aws_athena_workgroup.this.arn
}
