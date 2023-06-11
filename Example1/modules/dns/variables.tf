variable "domain_name" {
    type = string
    description = "the domain name of the web page"
}

variable "vpc_id" {
  description = "VPC ID for private hosted zone"
  type        = string
}
