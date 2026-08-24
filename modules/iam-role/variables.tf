variable "role_name" {
  description = "Nome da IAM Role"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON da policy de trust (AssumeRole)"
  type        = string
}

variable "managed_policy_arns" {
  description = "Lista de ARNs de policies gerenciadas para atachar a role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
