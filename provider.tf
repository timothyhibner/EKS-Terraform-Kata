provider "aws" {
  region                   = var.aws_region
  profile                  = "TFDeploy"
  shared_credentials_files = ["~/.aws/credentials"]

  default_tags {
    tags = var.tags
  }
}
