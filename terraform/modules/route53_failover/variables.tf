variable "domain_name" {
  description = "Root hosted zone domain name"
  type        = string
}

variable "record_name" {
  description = "Full DNS record name for failover app"
  type        = string
}

variable "primary_alb_dns_name" {
  type = string
}

variable "primary_alb_zone_id" {
  type = string
}

variable "secondary_alb_dns_name" {
  type = string
}

variable "secondary_alb_zone_id" {
  type = string
}