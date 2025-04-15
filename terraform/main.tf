# VPC MODULE
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "simpletimeservice-vpc"
  cidr = var.vpc_cidr

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# EKS MODULE
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.27"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      instance_types = [var.node_instance_type]
      desired_size   = 2
      min_size       = 1
      max_size       = 3
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



# BASTION EC2 INSTANCE

resource "aws_instance" "bastion" {
  ami                    = "ami-0c7217cdde317cfec" 
  instance_type          = "t3.micro"
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  key_name               = var.key_name

  vpc_security_group_ids = [module.eks.node_security_group_id]

  tags = {
    Name = "bastion-host"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y curl unzip awscli
              curl -LO https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
              chmod +x kubectl && mv kubectl /usr/local/bin/
              EOF
}
