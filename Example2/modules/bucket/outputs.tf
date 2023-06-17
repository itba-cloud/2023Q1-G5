# --------------------------------------------------------------------
# Amazon S3 buckets output
# --------------------------------------------------------------------

output "s3_zone_id" {
  value = aws_s3_bucket.main.hosted_zone_id
}


output "id" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = aws_s3_bucket.main.id
}

output "arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
  value       = aws_s3_bucket.main.arn
}

output "domain_name" {
  description = "The Domain Name of the bucket"
  value       = aws_s3_bucket.main.bucket_domain_name
}
