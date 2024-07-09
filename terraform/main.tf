provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  cluster_name = var.cluster_name
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "irsa_ebs_csi" {
  source = "./modules/irsa_ebs_csi"
  # Defina as variáveis conforme necessário
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "cluster-vpc"

  cidr = var.cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name                         = local.cluster_name
  cluster_version                      = var.eks_version
  vpc_id                               = module.vpc.vpc_id
  subnet_ids                           = module.vpc.private_subnets
  cluster_endpoint_public_access       = true
  cluster_endpoint_private_access      = true
  cluster_enabled_log_types            = var.cluster_enabled_log_types
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    default = {
      name           = "node-group-1"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 5
      desired_size   = 3
    },
    additional = {
      name           = "node-group-2"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 4
      desired_size   = 2
    }
  }
}