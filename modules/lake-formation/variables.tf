# Variaveis para lake_formation

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
