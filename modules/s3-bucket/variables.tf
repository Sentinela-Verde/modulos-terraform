variable "bucket_name" {
  description = "Nome do bucket S3"
  type        = string
}

variable "versioning_enabled" {
  description = "Habilitar versionamento no bucket"
  type        = bool
  default     = true
}

variable "block_public_access" {
  description = "Bloquear todo o acesso publico ao bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
