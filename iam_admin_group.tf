# ── IAM Admin Group ─────────────────────────────────────────────────────────────

resource "aws_iam_group" "admins" {
  name = var.admin_group_name
  path = "/admin/"
}

resource "aws_iam_group_policy_attachment" "admins_full_access" {
  group      = aws_iam_group.admins.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
