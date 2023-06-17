# 1 - S3 bucket
resource "aws_s3_bucket" "main" {
  bucket              = var.bucket_name
  object_lock_enabled = false

  tags = {
    Name = var.bucket_tag
  }
}

# 2 -Website configuration
resource "aws_s3_bucket_website_configuration" "main" {
  count  = var.index_file != null || var.redirect_hostname != null ? 1 : 0
  bucket = aws_s3_bucket.main.id

  dynamic "index_document" {
    for_each = var.index_file != null ? [1] : []
    content {
      suffix = var.index_file
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = var.redirect_hostname != null ? [1] : []
    content {
      host_name = var.redirect_hostname
    }
  }
}

# 3 - Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4 - Upload objects
resource "aws_s3_object" "main" {
  for_each = try(var.objects, {})
  bucket   = aws_s3_bucket.main.id
  key      = replace(each.value.filename, "html/", "")
  source   = format("./resources/%s", each.value.filename)
}