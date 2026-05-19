aws_region      = "us-east-2"
cluster_name    = "eks-kata-cluster"
cluster_version = "1.32"

vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-2a"]
private_subnet_cidrs = ["10.0.1.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24"]

cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] # Restrict to your IP in production

log_retention_days = 1

node_groups = {
  general = {
    instance_types = ["t3.micro"]
    capacity_type  = "SPOT"
    min_size       = 1
    max_size       = 3
    desired_size   = 1
    disk_size_gb   = 20
    labels         = { role = "general" }
    taints         = []
  }
}

eks_admin_role_arns = [
  "arn:aws:iam::575282423198:role/AWS-NoriPoint-Admin",
]

tags = {
  Project   = "EKS-Kata"
  ManagedBy = "Terraform"
  Env       = "dev"
}
