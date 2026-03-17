variable "aws_region" {}
variable "env" {}
variable "domain" {}

variable "tgw_id" {}
variable "tgw_rtb_id" {}
variable "vpc_id" {}

variable "tgw_subnet_ids" {
  type = list(string)
}

variable "cgw_public_ips" {
  type = list(string)
}

variable "cgw_bgp_asn" {}

variable "tags" {
  type = map(string)
}

variable "kms_key_arn" {
  type = string
}

variable "tgw_asn" {
  description = "Custom ASN for the AWS Transit Gateway"
  type        = number
  default     = 64612 # or whatever you need
}
