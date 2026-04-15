output "health_check_id" {
  value = module.route53_failover.health_check_id
}

output "record_fqdn" {
  value = module.route53_failover.record_fqdn
}