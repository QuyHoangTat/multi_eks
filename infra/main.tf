provider "aws" {
  region = "ap-southeast-1"
}
variable "project_name" {
  description = "Project name"
  type        = string
}

variable "project_env" {
  description = "Project environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  project_env  = var.project_env
  region       = var.region

  cidr            = var.cidr
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}

module "eks" {
  source = "../modules/eks"

  project_name = var.project_name
  project_env  = var.project_env
  region       = var.region

  vpc_id              = module.vpc.vpc_id
  vpc_private_subnets = module.vpc.private_subnets
}

output "project_name" {
  value = var.project_name
}

output "project_env" {
  value = var.project_env
}

output "region" {
  value = var.region
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_private_subnets" {
  value = module.vpc.private_subnets
}

output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
