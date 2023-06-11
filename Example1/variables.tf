variable "name" {
  type        = string
  description = "Name prefix for bucket S3"
}

variable "website_name" {
  type        = string
  description = "The name of the presentation tier. Must be less than or equal to 63 characters in length."
}

variable "igw_name" {
  description = "Name of the Internet Gateway."
  type        = string
}

