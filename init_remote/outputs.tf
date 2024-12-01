output "bucket_name" {
  value = aws_s3_bucket.terraform_state_bucket.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.terraform_lock_table.name
}