module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = var.table_name
  hash_key  = "id"
  range_key = "producto"

  attributes = [
    {
      name = "id"
      type = "N"
    },

    {
      name = "producto"
      type = "S"
    }
  ]



  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}