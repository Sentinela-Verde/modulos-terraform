module "logs_execucao" {
  source = "../../modules/cloudwatch"

  log_group_name    = "/sentinela-verde/plano-de-execucao"
  retention_in_days = 14

  create_alarm              = true
  alarm_name                = "sentinela-verde-execucao-cpu-alta"
  alarm_metric_name         = "CPUUtilization"
  alarm_namespace           = "AWS/EC2"
  alarm_comparison_operator = "GreaterThanThreshold"
  alarm_threshold           = 90
  alarm_dimensions = {
    InstanceId = "i-00000000000000000"
  }

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
