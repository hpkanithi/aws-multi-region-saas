output "current_account_id" {
  description = "AWS account ID currently in use"
  value       = data.aws_caller_identity.current.account_id
}

output "current_region" {
  description = "AWS region currently in use"
  value       = data.aws_region.current.name
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_1_id" {
  description = "Public subnet 1 ID"
  value       = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  description = "Public subnet 2 ID"
  value       = module.vpc.public_subnet_2_id
}

output "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  value       = module.vpc.private_subnet_1_id
}

output "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  value       = module.vpc.private_subnet_2_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "ecs_cluster_name" {
  value = module.ecs.ecs_cluster_name
}

output "ecs_service_name" {
  value = module.ecs.ecs_service_name
}