output "log_group_name" {
  description = "Nome do Log Group criado"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "ARN do Log Group criado"
  value       = aws_cloudwatch_log_group.this.arn
}

output "alarm_arn" {
  description = "ARN do alarme criado (vazio se create_alarm = false)"
  value       = try(aws_cloudwatch_metric_alarm.this[0].arn, null)
}
