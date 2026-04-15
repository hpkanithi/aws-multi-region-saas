module "route53_failover" {
  source = "../../modules/route53_failover"

  domain_name            = var.domain_name
  record_name            = var.record_name
  primary_alb_dns_name   = var.primary_alb_dns_name
  primary_alb_zone_id    = var.primary_alb_zone_id
  secondary_alb_dns_name = var.secondary_alb_dns_name
  secondary_alb_zone_id  = var.secondary_alb_zone_id
}