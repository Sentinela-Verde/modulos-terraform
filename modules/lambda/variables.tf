# Variaveis para lambda

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
