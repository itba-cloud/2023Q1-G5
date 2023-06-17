variable "api_gateway_name" {
  type        = string
  description = "Name prefix for api gateway"
  default     = "gaspiGateway"
}


variable "igw_name" {
  description = "Name of the Internet Gateway."
  type        = string
  default     = "igw"
}

variable "domain_name" {
  type        = string
  description = "the domain name of the web page"
  default     = "g3.com"
}

variable "bucket_name" {
  type        = string
  description = "A unique name for the Presentation layer bucket"
}

variable "table_name" {
  type        = string
  description = "A unique name for the sales dynamodb table"
}
