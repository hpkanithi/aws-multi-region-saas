variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "environment" {
  type = string
}