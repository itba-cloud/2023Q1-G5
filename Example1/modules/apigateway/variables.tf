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
   description = "id de la vpc"
}

variable "private_subnets_ids" {
  type = set(string)
  description = "ids de las privates subnets"
}

variable "lambda_function_name" {
  type = string
  description = "name of the lambda function"
  default = "lambda_function_helloworld"
}


variable "lambda_file_name" {
  type = string
  description = "name of the file of the lambda function"
  default = "lambda.zip"
}

variable "lambda_handler" {
  type = string
  description = "name of the handler of the lambda function"
  default = "lambda_query_payload.lambda_handler"
}

variable "lambda_runtime" {
  type = string
  description = "runtime for the lambda function"
  default = "python3.9"
}
