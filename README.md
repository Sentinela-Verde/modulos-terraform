# Modulos Terraform (AWS Terraform Modules)

Este repositório contém módulos reutilizáveis do Terraform para a infraestrutura AWS (projeto Mackenzie Data Engineer).
A ideia é que os repositórios dos projetos específicos (como o Lakehouse) apenas consumam esses módulos, centralizando a lógica, a segurança e as boas práticas aqui.

## Módulos Disponíveis

- [`s3-bucket`](modules/s3-bucket/): Provisionamento de Buckets S3 com versionamento e criptografia.
- [`iam-role`](modules/iam-role/): Criação de Roles e anexação de Policies do IAM.
- [`glue-job`](modules/glue-job/): Criação de Jobs do AWS Glue para processamento de dados.
- [`glue-catalog`](modules/glue-catalog/): Database e Crawler do AWS Glue Data Catalog.
- [`lambda`](modules/lambda/): Provisionamento de funções AWS Lambda.
- [`athena`](modules/athena/): Configuração de Workgroups do Athena.
- [`vpc`](modules/vpc/): VPC com sub-rede pública/privada e VPC Endpoints (S3, ECR, CloudWatch Logs) — sem NAT Gateway.
- [`ec2`](modules/ec2/): Instância EC2 genérica, on-demand ou Spot.
- [`ecr`](modules/ecr/): Repositório ECR com scan on push e lifecycle policy.
- [`cloudwatch`](modules/cloudwatch/): Log Group com retenção e alarme de métrica opcional.

Os módulos `iam-role`, `vpc`, `ec2`, `ecr`, `cloudwatch`, `glue-catalog` e `athena` tem um exemplo mínimo validado em [`examples/`](examples/).

> **Toda role criada via `iam-role` deve usar a permissions boundary da org** (`Sentinela-Verde-Workload-Boundary`), passada em `permissions_boundary_arn`. Busque o ARN por nome com `data "aws_iam_policy"` — nunca hardcode o ARN. Ver [`examples/iam-role/`](examples/iam-role/).

## Como Consumir (Naming Convention)

Exemplo de uso de um módulo em um repositório de projeto. 

> **Aviso:** O nome das pastas dos módulos utiliza hifens (`-`), mas a declaração do módulo no seu código local (`module "nome"`) deve utilizar underlines (`_`) por convenção do Terraform.

```hcl
module "datalake_bucket" {
  # Apontando para o repositório centralizado no GitHub:
  source = "git::https://github.com/Sentinela-Verde/modulos-terraform.git//modules/s3-bucket?ref=v1"
  
  bucket_name = "mackenzie-datalake-bronze"
  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}

module "glue_job_lakehouse" {
  source = "git::https://github.com/Sentinela-Verde/modulos-terraform.git//modules/glue-job?ref=v1"

  job_name        = "production-lakehouse-glue-jobs"
  role_arn        = "arn:aws:iam::123456789012:role/MinhaRole"
  script_location = "s3://meu-bucket/scripts/gluejob.py"
}
```

## CI/CD (Validação)

Este repositório possui uma action configurada em `.github/workflows/terraform-validate.yml` que executa testes de sintaxe (`terraform validate`) e checagem de formatação (`terraform fmt`) em todos os módulos automaticamente sempre que uma alteração é enviada para garantir a qualidade do código.