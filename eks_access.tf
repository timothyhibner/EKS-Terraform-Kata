# ── EKS Access Entries ───────────────────────────────────────────────────────────
# Grants IAM roles/users access inside the Kubernetes cluster.
# Replaces manual aws-auth ConfigMap edits.

resource "aws_eks_access_entry" "admins" {
  for_each = toset(var.eks_admin_role_arns)

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = each.value
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "admins" {
  for_each = toset(var.eks_admin_role_arns)

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = each.value
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

  depends_on = [aws_eks_access_entry.admins]
}
