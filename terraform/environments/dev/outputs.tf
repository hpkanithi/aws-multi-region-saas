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

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "Private subnet ID"
  value       = module.vpc.private_subnet_id
}