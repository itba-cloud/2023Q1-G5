module "bucket" {
  source       = "./modules/bucket"
  website_name = var.website_name
  name         = var.name
}
