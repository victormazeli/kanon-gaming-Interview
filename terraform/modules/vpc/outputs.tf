output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

output "private_us_east_1a" {
  value = aws_subnet.eks-private-us-east-1a.id
}

output "private_us_east_1b" {
  value = aws_subnet.eks-private-us-east-1b.id
}

output "public_us_east_1a" {
  value = aws_subnet.eks-public-us-east-1a.id
}

output "public_us_east_1b" {
  value = aws_subnet.eks-public-us-east-1b.id
}
