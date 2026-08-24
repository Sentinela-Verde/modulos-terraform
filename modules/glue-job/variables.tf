variable "job_name" {
  description = "Nome do AWS Glue Job"
  type        = string
}

variable "role_arn" {
  description = "ARN da IAM Role que o Glue Job ira assumir"
  type        = string
}

variable "script_location" {
  description = "Caminho no S3 para o script do Glue (ex: s3://meu-bucket/scripts/job.py)"
  type        = string
}

variable "command_name" {
  description = "O nome do comando do job. (ex: glueetl, pythonshell, gluestreaming)"
  type        = string
  default     = "glueetl"
}

variable "python_version" {
  description = "Versao do Python usada no job (depende da versao do glue)"
  type        = string
  default     = "3"
}

variable "glue_version" {
  description = "Versao do AWS Glue"
  type        = string
  default     = "4.0"
}

variable "worker_type" {
  description = "Tipo de worker alocado (Standard, G.1X, G.2X)"
  type        = string
  default     = "G.1X"
}

variable "number_of_workers" {
  description = "Numero de workers alocados quando G.1X ou G.2X"
  type        = number
  default     = 2
}

variable "max_retries" {
  description = "Numero maximo de retentativas do job em caso de falha"
  type        = number
  default     = 0
}

variable "timeout" {
  description = "Timeout do job em minutos"
  type        = number
  default     = 2880
}

variable "default_arguments" {
  description = "Argumentos padroes do job (ex: --job-language, --TempDir, etc)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
