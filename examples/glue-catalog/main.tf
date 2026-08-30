module "catalogo_lakehouse" {
  source = "../../modules/glue-catalog"

  database_name        = "sentinela_verde_curated"
  database_description = "Dados curados do lakehouse, prontos para consulta via Athena"

  create_crawler         = true
  crawler_name           = "sentinela-verde-crawler-curated"
  crawler_role_arn       = "arn:aws:iam::123456789012:role/GlueCrawlerRole"
  crawler_s3_target_path = "s3://sentinela-verde-lakehouse/curated/"
  crawler_schedule       = "cron(0 6 * * ? *)"

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
