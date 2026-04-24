module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  env = var.env
  azs = var.azs
  pub_sub_1_cidr = var.pub_sub_1_cidr
  pub_sub_2_cidr = var.pub_sub_2_cidr
  priv_sub_1_cidr = var.priv_sub_1_cidr
  priv_sub_2_cidr = var.priv_sub_2_cidr
}
    