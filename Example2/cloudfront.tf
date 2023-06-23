module "cloudfront" {
  source      = "./modules/cloudfront"
  bucket_name = local.bucket_name
  s3_id       = module.bucket["website"].id
  depends_on  = [module.bucket["website"].id]
  domain_name = module.bucket["website"].domain_name
}