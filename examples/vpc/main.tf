module "vpc" {
  source = "../../modules/vpc"

  name              = "sentinela-verde"
  availability_zone = "us-east-1a"

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
  }
}
