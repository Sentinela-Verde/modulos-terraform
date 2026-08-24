# AWS Terraform Modules

Este repositório contém módulos reutilizáveis do Terraform para a infraestrutura AWS (projeto Mackenzie Data Engineer).
A ideia é que os repositórios dos projetos específicos apenas consumam esses módulos, centralizando a lógica e as boas práticas aqui.

## Módulos Disponíveis
- `s3_bucket`: Provisionamento de Buckets S3.
- `iam_role`: Criação de Roles e Policies do IAM.
- `glue_job`: Criação de Jobs do AWS Glue.
- `lambda`: Provisionamento de funções AWS Lambda.
- `athena`: Configuração de Databases e Workgroups do Athena.
- `lake_formation`: Permissões granulares e settings do Lake Formation.
- `sagemaker`: Infraestrutura base para o Amazon SageMaker.

## Como Consumir

Exemplo de uso de um módulo em um repositório de projeto:

```hcl
module "datalake_bucket" {
  # Quando versionado no git: source = "git::https://github.com/sua-org/terraform-aws-modules.git//modules/s3_bucket?ref=main"
  source = "../../terraform-aws-modules/modules/s3_bucket"
  
  bucket_name = "mackenzie-datalake-bronze"
  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
```