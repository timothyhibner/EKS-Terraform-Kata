terraform {
  backend "s3" {
    bucket         = "eks-kata-terraform-state"
    key            = "eks-kata/terraform.tfstate"
    region         = "us-east-2"
    profile        = "TFDeploy"
    encrypt        = true
    use_lockfile   = true
  }
}
