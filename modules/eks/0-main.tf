# https://github.com/terraform-aws-modules/terraform-aws-eks
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "${var.project_name}-${var.project_env}"
  cluster_version = "1.29"

  vpc_id     = var.vpc_id # module.vpc.vpc_id
  subnet_ids = var.vpc_private_subnets # module.vpc.private_subnets

  # cluster_endpoint_private_access = true
  # cluster_endpoint_public_access  = true

  eks_managed_node_group_defaults = {
    disk_size      = 8
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    # blue = {
    #   desired_size = 0
    # }
    worker-group = {
      min_size     = 1
      max_size     = 5
      desired_size = 3

      instance_types                = ["t2.medium"]
      capacity_type                 = "ON_DEMAND" # SPOT
      # additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }

  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }

    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      # ipv6_cidr_blocks = ["::/0"]
    }
  }

}
