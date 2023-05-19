variable "endpoint_path" {
  description = "Get the endpoint path"
  type        = string
  default     = "Bebida"
}

variable "name" {
  description = "name of the Api Gateway"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets_ids" {
  type = set(string)
}