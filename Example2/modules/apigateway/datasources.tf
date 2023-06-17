data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./resources/lambda/lambda_query_payload.py"
  output_path = "./resources/lambda/lambda.zip"
}

data "aws_caller_identity" "current" {}
