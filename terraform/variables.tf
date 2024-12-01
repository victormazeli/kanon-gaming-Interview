variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "repository_name" {
  description = "ECR Name"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "Instance type for worker nodes for EKS"
  type        = string
}

variable "capacity_type" {
  description = "Capacity type of each ec2 node"
  type        = string
}

variable "cluster_role_name" {
  description = "Name of the IAM role for the EKS cluster"
  type        = string
}

variable "node_role_name" {
  description = "Name of the IAM role for the EKS nodes"
  type        = string
}