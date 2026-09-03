data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Toda role criada via Terraform deve usar a permissions boundary da org --
# busca por nome, nunca por ARN hardcoded (mesmo padrao de examples/iam-role/).
data "aws_iam_policy" "workload_boundary" {
  name = "Sentinela-Verde-Workload-Boundary"
}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  # Nome do bucket nunca hardcoded -- se nao informado, deriva de conta+regiao
  # (ambos resolvidos via data source), garantindo unicidade sem sufixo arbitrario.
  mlflow_bucket_name = coalesce(
    var.mlflow_bucket_name,
    "sentinela-verde-mlflow-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  )

  docker_compose_content = templatefile("${path.module}/templates/docker-compose.yml.tpl", {
    postgres_password = var.postgres_password
    mlflow_image_uri  = var.mlflow_image_uri
    mlflow_bucket     = local.mlflow_bucket_name
  })

  user_data = templatefile("${path.module}/templates/user-data.sh.tpl", {
    swap_size_gb           = var.swap_size_gb
    docker_compose_content = local.docker_compose_content
    postgres_password      = var.postgres_password
    mlflow_bucket          = local.mlflow_bucket_name
  })
}

module "mlflow_bucket" {
  source = "../../modules/s3-bucket"

  bucket_name = local.mlflow_bucket_name
  tags        = var.tags
}

resource "aws_iam_policy" "mlflow_s3_access" {
  name        = "${var.name}-mlflow-s3-access"
  description = "Leitura/escrita no bucket de artefatos e backups do MLflow"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        ]
        Resource = [
          module.mlflow_bucket.bucket_arn,
          "${module.mlflow_bucket.bucket_arn}/*",
        ]
      }
    ]
  })

  tags = var.tags
}

module "instance_role" {
  source = "../../modules/iam-role"

  role_name = "${var.name}-instance-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
      }
    ]
  })

  managed_policy_arns      = [aws_iam_policy.mlflow_s3_access.arn]
  permissions_boundary_arn = data.aws_iam_policy.workload_boundary.arn

  tags = var.tags
}

# modules/ec2 nao cria instance profile -- so aceita um nome, criamos aqui.
resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-instance-profile"
  role = module.instance_role.role_name

  tags = var.tags
}

resource "aws_security_group" "controle" {
  name        = "${var.name}-controle"
  description = "SSH e UI do MLflow para a EC2 de controle"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  ingress {
    description = "MLflow UI"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.name}-controle" })
}

module "controle" {
  source = "../../modules/ec2"

  name                 = var.name
  ami_id               = data.aws_ami.al2023.id
  instance_type        = var.instance_type
  subnet_id            = var.subnet_id
  security_group_ids   = [aws_security_group.controle.id]
  iam_instance_profile = aws_iam_instance_profile.this.name
  key_name             = var.key_name
  user_data            = local.user_data
  associate_public_ip  = true
  root_volume_size     = var.root_volume_size

  tags = merge(var.tags, { Papel = "plano-de-controle" })
}
