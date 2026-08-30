variable "database_name" {
  description = "Nome do Glue Data Catalog Database"
  type        = string
}

variable "database_description" {
  description = "Descricao do database"
  type        = string
  default     = ""
}

variable "create_crawler" {
  description = "Se true, cria um Glue Crawler apontando para o S3"
  type        = bool
  default     = false
}

variable "crawler_name" {
  description = "Nome do crawler (obrigatorio se create_crawler = true)"
  type        = string
  default     = null
}

variable "crawler_role_arn" {
  description = "ARN da IAM Role usada pelo crawler"
  type        = string
  default     = null
}

variable "crawler_s3_target_path" {
  description = "Caminho S3 que o crawler varre (ex: s3://meu-bucket/curated/)"
  type        = string
  default     = null
}

variable "crawler_schedule" {
  description = "Expressao cron do agendamento do crawler. Nulo roda so sob demanda"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
