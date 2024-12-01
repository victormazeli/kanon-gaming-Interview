resource "aws_ecr_repository" "eks_image_repository" {
  name = var.repository_name

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = var.repository_name
  }

  image_scanning_configuration {
    scan_on_push = true # Scan images automatically when pushed to the repository
  }

}

