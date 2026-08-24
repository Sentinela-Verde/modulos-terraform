# Central Workflows (AWS Terraform Modules)

Este repositório contém módulos reutilizáveis do Terraform para a infraestrutura AWS (projeto Mackenzie Data Engineer).
A ideia é que os repositórios dos projetos específicos (como o Lakehouse) apenas consumam esses módulos, centralizando a lógica, a segurança e as boas práticas aqui.

## Módulos Disponíveis

- [`s3-bucket`](modules/s3-bucket/): Provisionamento de Buckets S3 com versionamento e criptografia.
- [`iam-role`](modules/iam-role/): Criação de Roles e anexação de Policies do IAM.
- [`glue-job`](modules/glue-job/): Criação de Jobs do AWS Glue para processamento de dados.
- [`lambda`](modules/lambda/): Provisionamento de funções AWS Lambda.
- [`athena`](modules/athena/): Configuração de Databases e Workgroups do Athena.
- [`lake-formation`](modules/lake-formation/): Permissões granulares e settings do Lake Formation.
- [`sagemaker`](modules/sagemaker/): Infraestrutura base para o Amazon SageMaker.

## Como Consumir (Naming Convention)

Exemplo de uso de um módulo em um repositório de projeto. 

> **Aviso:** O nome das pastas dos módulos utiliza hifens (`-`), mas a declaração do módulo no seu código local (`module "nome"`) deve utilizar underlines (`_`) por convenção do Terraform.

```hcl
module "datalake_bucket" {
  # Apontando para o repositório centralizado no GitHub:
  source = "git::https://github.com/Sentinela-Verde/central-workflows.git//modules/s3-bucket?ref=develop"
  
  bucket_name = "mackenzie-datalake-bronze"
  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}

module "glue_job_lakehouse" {
  source = "git::https://github.com/Sentinela-Verde/central-workflows.git//modules/glue-job?ref=develop"

  job_name        = "production-lakehouse-glue-jobs"
  role_arn        = "arn:aws:iam::123456789012:role/MinhaRole"
  script_location = "s3://meu-bucket/scripts/gluejob.py"
}
```

## CI/CD (Validação)

Este repositório possui uma action configurada em `.github/workflows/terraform-validate.yml` que executa testes de sintaxe (`terraform validate`) e checagem de formatação (`terraform fmt`) em todos os módulos automaticamente sempre que uma alteração é enviada para garantir a qualidade do código.