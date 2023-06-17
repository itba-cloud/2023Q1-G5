locals {
  #AWS VPC config
  aws_vpc_network = "10.0.0.0/16"
  aws_az_count    = 2

  modules_path = "./modules"
  path         = "./resources"
  bucket_name  = var.bucket_name
  region       = "us-east-1"
  az1          = "${local.region}a"

  bucketsito = {

    # 1 - Website
    website = {
      bucket_name        = local.bucket_name
      path               = local.path
      index_file         = "index.html"
      public_read_policy = true
      bucket_tag         = "Front Website Bucket"
      objects = {
        index = {
          filename = "html/index.html"
        }
      }
    }

    # 2 - WWW Website
    www-website = {
      bucket_name       = "www.${local.bucket_name}"
      redirect_hostname = "${local.bucket_name}.s3-website-${local.region}.amazonaws.com"
      bucket_tag        = "Front www Bucket"
    }

    # 3 - Logs
    website-logs = {
      bucket_name = "${local.bucket_name}-logs"
      bucket_tag  = "Front Logs Bucket"
    }
  }
}