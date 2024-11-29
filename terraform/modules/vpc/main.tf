resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name                                        = "eks_vpc"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }
}

resource "aws_subnet" "eks-private-us-east-1a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    "Name"                                      = "eks-private-us-east-1a"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }
}

resource "aws_subnet" "eks-private-us-east-1b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    "Name"                                      = "eks-private-us-east-1b"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }
}

resource "aws_subnet" "eks-public-us-east-1a" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "eks-public-us-east-1a"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }
}

resource "aws_subnet" "eks-public-us-east-1b" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "eks-public-us-east-1b"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }
}


resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "eks-igw"
  }
}


resource "aws_eip" "eks_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.eks_igw]

  tags = {
    Name = "eks-eip"
  }
}

resource "aws_nat_gateway" "eks_nat" {
  allocation_id = aws_eip.eks_eip.id
  subnet_id     = aws_subnet.eks-public-us-east-1a.id

  tags = {
    Name = "eks-nat"
  }

  depends_on = [aws_internet_gateway.eks_igw]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_nat.id
  }
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.eks-private-us-east-1a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.eks-private-us-east-1b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.eks-public-us-east-1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.eks-public-us-east-1b.id
  route_table_id = aws_route_table.public.id
}