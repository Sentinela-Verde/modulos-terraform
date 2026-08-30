variable "name" {
  description = "Nome da instancia (usado na tag Name)"
  type        = string
}

variable "ami_id" {
  description = "ID da AMI a utilizar"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instancia EC2"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a instancia sera criada"
  type        = string
}

variable "security_group_ids" {
  description = "Lista de Security Group IDs associados a instancia"
  type        = list(string)
  default     = []
}

variable "iam_instance_profile" {
  description = "Nome do IAM Instance Profile associado a instancia"
  type        = string
  default     = null
}

variable "key_name" {
  description = "Nome do EC2 Key Pair para acesso SSH"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Script de inicializacao da instancia (user data)"
  type        = string
  default     = null
}

variable "associate_public_ip" {
  description = "Se a instancia recebe IP publico"
  type        = bool
  default     = false
}

variable "is_spot" {
  description = "Se true, a instancia e provisionada como Spot Instance"
  type        = bool
  default     = false
}

variable "spot_max_price" {
  description = "Preco maximo por hora para a Spot Instance. Nulo usa o preco sob demanda como teto"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Tamanho do volume raiz em GB"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
