variable "name" {
  description = "Nome base usado nas tags e nos recursos desta stack"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde o security group desta stack sera criado"
  type        = string
}

variable "subnet_id" {
  description = "ID da subnet onde a EC2 de controle sera criada (deve ser a subnet publica)"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instancia EC2 de controle"
  type        = string
  default     = "t3.micro"
}

variable "allowed_cidr_blocks" {
  description = "Blocos CIDR autorizados a acessar SSH (22) e a UI do MLflow (5000). Sem default -- nunca abrir para 0.0.0.0/0 por omissao"
  type        = list(string)
}

variable "key_name" {
  description = "Nome do EC2 Key Pair para acesso SSH. Nulo desativa acesso SSH por chave"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Tamanho do volume raiz em GB"
  type        = number
  default     = 20
}

variable "postgres_password" {
  description = "Senha do usuario mlflow no PostgreSQL"
  type        = string
  sensitive   = true
}

variable "mlflow_bucket_name" {
  description = "Nome do bucket S3 usado como artifact store do MLflow. Nulo gera um nome derivado da conta e regiao"
  type        = string
  default     = null
}

variable "mlflow_image_uri" {
  description = "URI completa da imagem Docker do MLflow publicada no ECR (ver .github/workflows/publicar-imagem.yml no repo automacao-cicd)"
  type        = string
}

variable "swap_size_gb" {
  description = "Tamanho do swapfile criado na instancia, em GB"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags padrao aplicadas aos recursos"
  type        = map(string)
  default     = {}
}
