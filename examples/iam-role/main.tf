# Toda role criada via Terraform deve usar a permissions boundary da org --
# busca por nome, nunca por ARN hardcoded (o ARN muda entre contas/ambientes).
data "aws_iam_policy" "workload_boundary" {
  name = "Sentinela-Verde-Workload-Boundary"
}

module "lambda_role" {
  source = "../../modules/iam-role"

  role_name = "minha-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
      }
    ]
  })

  permissions_boundary_arn = data.aws_iam_policy.workload_boundary.arn

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
