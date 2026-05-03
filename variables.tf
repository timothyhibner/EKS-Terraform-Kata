variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-kata-cluster"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.32"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets (worker nodes)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (load balancers)"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "node_groups" {
  description = "Map of managed node group configurations"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    min_size       = number
    max_size       = number
    desired_size   = number
    disk_size_gb   = number
    labels         = map(string)
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
  default = {
    general = {
      instance_types = ["t3.micro", "t3.medium"]
      capacity_type  = "SPOT"
      min_size       = 1
      max_size       = 4
      desired_size   = 2
      disk_size_gb   = 20
      labels         = { role = "general" }
      taints         = []
    }
  }
}

variable "cluster_endpoint_public_access" {
  description = "Whether the EKS cluster API endpoint is publicly accessible"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDR blocks allowed to reach the public cluster endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_cluster_addons" {
  description = "EKS managed add-ons to install"
  type        = map(string)
  default = {
    coredns    = "latest"
    kube-proxy = "latest"
    vpc-cni    = "latest"
    aws-ebs-csi-driver = "latest"
  }
}

variable "eks_admin_role_arns" {
  description = "List of IAM role ARNs to grant cluster-admin access inside EKS"
  type        = list(string)
  default     = []
}

variable "admin_group_name" {
  description = "Name of the IAM group granted AdministratorAccess"
  type        = string
  default     = "eks-kata-admins"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "EKS-Kata"
    ManagedBy   = "Terraform"
  }
}
