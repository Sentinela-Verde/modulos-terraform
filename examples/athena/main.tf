module "workgroup_analistas" {
  source = "../../modules/athena"

  workgroup_name  = "sentinela-verde-analistas"
  output_location = "s3://sentinela-verde-lakehouse/athena-results/"

  bytes_scanned_cutoff_per_query = 10737418240 # 10 GB

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
