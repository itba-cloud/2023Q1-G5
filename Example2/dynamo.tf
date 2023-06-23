module "dns" {
  source     = "./modules/dynamo"
  table_name = var.table_name
}