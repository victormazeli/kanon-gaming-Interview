terraform {
  backend "s3" {
    bucket         = "devops-kanon-terraform-state-bucket"
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "devops-kanon-terraform-lock-table"
    acl            = "private"
  }
}
