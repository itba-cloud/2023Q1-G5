
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_query_payload.py"
  output_path = "lambda.zip"
}

data "aws_caller_identity" "current"{}
