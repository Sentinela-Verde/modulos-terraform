output "job_arn" {
  description = "ARN do Glue Job"
  value       = aws_glue_job.this.arn
}

output "job_id" {
  description = "ID do Glue Job"
  value       = aws_glue_job.this.id
}

output "job_name" {
  description = "Nome do Glue Job"
  value       = aws_glue_job.this.name
}
