resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "this" {
  count = var.create_alarm ? 1 : 0

  alarm_name          = var.alarm_name
  comparison_operator = var.alarm_comparison_operator
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = var.alarm_metric_name
  namespace           = var.alarm_namespace
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_threshold
  dimensions          = var.alarm_dimensions
  alarm_actions       = var.alarm_actions

  tags = var.tags
}
