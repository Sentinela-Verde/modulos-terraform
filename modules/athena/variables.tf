variable "workgroup_name" {
  description = "Nome do Athena Workgroup"
  type        = string
}

variable "output_location" {
  description = "Caminho S3 onde os resultados das queries sao salvos (ex: s3://meu-bucket/athena-results/)"
  type        = string
}

variable "enforce_workgroup_configuration" {
  description = "Se true, forca todas as queries do workgroup a usarem esta configuracao"
  type        = bool
  default     = true
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Limite de bytes escaneados por query. Nulo desativa o limite"
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
