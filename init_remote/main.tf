resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "devops-kanon-terraform-state-bucket"


  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "Terraform State Bucket"
  }
}

# Create DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_lock_table" {
  name           = "devops-kanon-terraform-lock-table"
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }


  tags = {
    Name = "Terraform Lock Table"
  }
}
