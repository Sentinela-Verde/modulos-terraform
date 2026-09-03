module "controle" {
  source = "../../stacks/controle"

  name      = "sentinela-verde-controle"
  vpc_id    = "vpc-00000000000000000"
  subnet_id = "subnet-00000000000000000"

  allowed_cidr_blocks = ["203.0.113.0/24"] # substitua pelo CIDR real da equipe

  postgres_password = "troque-esta-senha" # em producao, vem de uma variavel sensivel/secret manager
  mlflow_image_uri  = "149465616406.dkr.ecr.us-east-1.amazonaws.com/mlflow-server:latest"

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
    Papel    = "plano-de-controle"
  }
}
