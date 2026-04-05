data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr              = "10.0.0.0/16"
  public_subnet_1_cidr  = "10.0.1.0/24"
  public_subnet_2_cidr  = "10.0.2.0/24"
  private_subnet_1_cidr = "10.0.11.0/24"
  private_subnet_2_cidr = "10.0.12.0/24"

  environment = var.environment
}

module "security_groups" {
  source = "../../modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  subnets           = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.alb_sg_id
}