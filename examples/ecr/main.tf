module "ecr_etl" {
  source = "../../modules/ecr"

  repository_name = "sentinela-verde-etl"
  max_image_count = 5

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
