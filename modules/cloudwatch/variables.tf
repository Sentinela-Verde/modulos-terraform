variable "log_group_name" {
  description = "Nome do CloudWatch Log Group"
  type        = string
}

variable "retention_in_days" {
  description = "Dias de retencao dos logs"
  type        = number
  default     = 30
}

variable "create_alarm" {
  description = "Se true, cria um CloudWatch Metric Alarm associado"
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "Nome do alarme (obrigatorio se create_alarm = true)"
  type        = string
  default     = null
}

variable "alarm_metric_name" {
  description = "Nome da metrica monitorada pelo alarme"
  type        = string
  default     = null
}

variable "alarm_namespace" {
  description = "Namespace da metrica (ex: AWS/EC2, AWS/Lambda)"
  type        = string
  default     = null
}

variable "alarm_comparison_operator" {
  description = "Operador de comparacao do alarme"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "alarm_threshold" {
  description = "Limite que dispara o alarme"
  type        = number
  default     = null
}

variable "alarm_evaluation_periods" {
  description = "Numero de periodos avaliados antes de disparar o alarme"
  type        = number
  default     = 2
}

variable "alarm_period" {
  description = "Duracao de cada periodo avaliado, em segundos"
  type        = number
  default     = 300
}

variable "alarm_dimensions" {
  description = "Dimensoes da metrica monitorada (ex: { InstanceId = \"i-123\" })"
  type        = map(string)
  default     = {}
}

variable "alarm_actions" {
  description = "ARNs acionados quando o alarme dispara (ex: SNS topic)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
