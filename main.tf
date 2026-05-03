data "aws_caller_identity" "current" {}

data "aws_eks_addon_version" "this" {
  for_each = var.enable_cluster_addons

  addon_name         = each.key
  kubernetes_version = var.cluster_version
  most_recent        = each.value == "latest" ? true : false
}
