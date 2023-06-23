variable "endpoint_path" {
  description = "Get the endpoint path"
  type        = string
  default     = "Bebida"
}

variable "vpc_id" {
  type        = string
  description = "id de la vpc"
}

variable "private_subnets_ids" {
  type        = set(string)
  description = "ids de las privates subnets"
}

variable "lambda_function_name" {
  type        = string
  description = "name of the lambda function"
  default     = "lambda_function_helloworld"
}


variable "lambda_file_name" {
  type        = string
  description = "Path to the function's deployment package within the local filesystem."
  default     = "./resources/lambda/lambda.zip"
}

variable "lambda_handler" {
  type        = string
  description = "name of the handler of the lambda function"
  default     = "lambda_query_payload.lambda_handler"
}

variable "lambda_runtime" {
  type        = string
  description = "runtime for the lambda function"
  default     = "python3.9"
}

variable "api_gateway_name" {
  type        = string
  description = "Name of the Api Gateway"
}
