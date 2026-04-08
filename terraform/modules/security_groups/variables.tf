variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "container_port" {
  type    = number
  default = 80
}

variable "environment" {
  type = string
}