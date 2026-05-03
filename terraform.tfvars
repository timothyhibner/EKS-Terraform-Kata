aws_region      = "us-east-2"
cluster_name    = "eks-kata-cluster"
cluster_version = "1.32"

vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-2a", "us-east-2b", "us-east-2c"]
private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnet_cidrs  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] # Restrict to your IP in production

node_groups = {
  general = {
    instance_types = ["t3.micro", "t3.micro"] # Multiple types improve spot availability
    capacity_type  = "SPOT" # Use free tier for cost savings
    min_size       = 1
    max_size       = 5
    desired_size   = 2
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
