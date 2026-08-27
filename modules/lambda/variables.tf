variable "function_name" {
  description = "O nome da funcao Lambda"
  type        = string
}

variable "role_arn" {
  description = "ARN da IAM Role que a Lambda ira assumir"
  type        = string
}

variable "filename" {
  description = "Caminho do arquivo .zip contendo o codigo da Lambda"
  type        = string
}

variable "handler" {
  description = "Ponto de entrada (handler) da Lambda"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "runtime" {
  description = "Runtime da funcao Lambda (ex: python3.9, nodejs18.x)"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "Timeout em segundos"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Quantidade de memoria em MB"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Variaveis de ambiente para a Lambda"
  type        = map(string)
  default     = null
}

variable "source_code_hash" {
  description = "Hash do arquivo fonte (usado para detectar mudancas no zip)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
