module "bucket" {
  for_each = local.bucketsito
  source   = "./modules/bucket"


  bucket_name        = each.value.bucket_name
  objects            = try(each.value.objects, {})
  public_read_policy = try(each.value.public_read_policy, false)
  index_file         = try(each.value.index_file, null)
  redirect_hostname  = try(each.value.redirect_hostname, null)
  bucket_tag         = each.value.bucket_tag
}
