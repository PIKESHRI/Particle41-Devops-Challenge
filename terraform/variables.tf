variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "cluster_name" {
  default = "simpletimeservice-cluster"
}

variable "container_image" {
  default = "piyushkeshri30/simpletimeservice" 
}

variable "node_instance_type" {
  default = "t3.medium"
}

variable "key_name" {
  description = "SSH key name for the bastion host"
}