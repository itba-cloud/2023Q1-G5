variable "name" {
  type        = string
  description = "Name prefix for bucket S3"
}

variable "website_name" {
  type        = string
  description = "The name of the presentation tier. Must be less than or equal to 63 characters in length."
}

variable "objects" {
  type        = map(any)
  description = "Every object inserted in the bucket"
  default     = {}
}

variable "www_bucket_tags" {
  type        = map(string)
  description = "Tags for the www bucket."
  default     = {}
}

variable "bucket_tags" {
  type        = map(string)
  description = "Tags for the mian bucket."
  default     = {}
}

variable "bucket_log_tags" {
  type        = map(string)
  description = "Tags for the logs bucket."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags for all the buckets."
  default     = {}
}