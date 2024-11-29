module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  cluster_name        = var.cluster_name
}


module "eks_cluster" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  instance_type      = var.instance_type
  private_subnet_ids = [module.vpc.private_us_east_1a, module.vpc.private_us_east_1b]
  subnet_ids         = [module.vpc.private_us_east_1a, module.vpc.private_us_east_1b, module.vpc.public_us_east_1a, module.vpc.public_us_east_1b]
  capacity_type      = var.capacity_type
  cluster_role_name  = var.cluster_role_name
  node_role_name     = var.node_role_name
}
