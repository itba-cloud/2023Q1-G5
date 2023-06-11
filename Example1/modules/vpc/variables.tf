variable "cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "zones_count" {
  description = "Number of zones."
  type        = number
  default     = 2
}

variable "igw_name" {
  description = "Name of the Internet Gateway."
  type        = string
}
variable "subnet" {
  type        = map(any)
  description = "subnet"
  default     = {}
}
