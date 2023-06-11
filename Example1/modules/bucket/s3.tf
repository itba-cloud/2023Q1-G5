resource "aws_s3_bucket" "www" {
  bucket = "www.${var.website_name}"
  tags = merge(
    {
      "Name" = "www.${var.website_name}"
    },
    var.tags,
    var.www_bucket_tags
  )
}

resource "aws_s3_bucket" "main" {
  bucket_prefix = var.name

  tags = {
    Name        = "front-public-bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "logs" {
  bucket = "logs.${var.website_name}"
  tags = merge(
    {
      "Name" = "${var.website_name}-logs"
    },
    var.tags,
    var.bucket_log_tags
  )
}


resource "aws_s3_bucket_versioning" "aws_s3_bucket_versioning" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.main.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "this" {
  for_each     = try(var.objects, {})
  bucket       = aws_s3_bucket.main.id
  key          = try(each.value.rendered, replace(each.value.filename, "html/", ""))
  source       = try(each.value.rendered, format("../../../resources", each.value.filename))
  content_type = each.value.content_type
}