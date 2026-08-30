variable "repository_name" {
  description = "Nome do repositorio ECR"
  type        = string
}

variable "image_tag_mutability" {
  description = "Mutabilidade das tags de imagem (MUTABLE ou IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Se true, escaneia a imagem por vulnerabilidades a cada push"
  type        = bool
  default     = true
}

variable "max_image_count" {
  description = "Numero maximo de imagens mantidas antes de expirar as mais antigas"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
