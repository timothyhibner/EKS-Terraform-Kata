variable "aws_region" {
  description = "AWS region for the state bucket and lock table"
  type        = string
  default     = "us-east-2"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
  default     = "eks-kata-terraform-state"
}

variable "tags" {
  description = "Common tags applied to all bootstrap resources"
  type        = map(string)
  default = {
    Project   = "EKS-Kata"
    ManagedBy = "Terraform"
  }
}
