# Plano de controle: sob demanda, sub-rede publica, sempre ativa.
module "plano_de_controle" {
  source = "../../modules/ec2"

  name                 = "sentinela-verde-controle"
  ami_id               = "ami-0000000000000000"
  instance_type        = "t3.medium"
  subnet_id            = "subnet-00000000000000000"
  security_group_ids   = ["sg-00000000000000000"]
  iam_instance_profile = "ec2-controle-profile"
  associate_public_ip  = true

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
    Papel    = "plano-de-controle"
  }
}

# Plano de execucao: Spot, sub-rede privada, efemera -- uma por workload.
module "plano_de_execucao" {
  source = "../../modules/ec2"

  name                 = "sentinela-verde-execucao"
  ami_id               = "ami-0000000000000000"
  instance_type        = "t3.large"
  subnet_id            = "subnet-11111111111111111"
  security_group_ids   = ["sg-11111111111111111"]
  iam_instance_profile = "ec2-execucao-profile"
  is_spot              = true
  spot_max_price       = "0.05"

  tags = {
    Ambiente = "producao"
    Projeto  = "projeto_final"
    Papel    = "plano-de-execucao"
  }
}
