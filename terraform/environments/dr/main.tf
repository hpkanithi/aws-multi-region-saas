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

  environment    = var.environment
  vpc_id         = module.vpc.vpc_id
  container_port = 80
}

module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  subnets           = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.alb_sg_id
  environment       = var.environment
}

module "ecs" {
  source = "../../modules/ecs"

  environment           = var.environment
  aws_region            = var.aws_region
  subnet_ids            = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  ecs_security_group_id = module.security_groups.ecs_sg_id
  target_group_arn      = module.alb.target_group_arn
  container_image       = "177362732651.dkr.ecr.us-east-1.amazonaws.com/ecs-demo-app:latest"
  container_port        = 80
}

module "monitoring" {
  source = "../../modules/monitoring"

  environment             = var.environment
  ecs_cluster_name        = module.ecs.ecs_cluster_name
  ecs_service_name        = module.ecs.ecs_service_name
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
}