locals {
  role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole"
}