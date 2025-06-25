data "aws_iam_policy_document" "github_oidc_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${var.aws_account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.repo_owner}/${var.repo_name}:*"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}


resource "aws_iam_role_policy_attachment" "terraform_permissions" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}