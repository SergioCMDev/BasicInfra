resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsTerraformRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
  depends_on = [
    var.github_openid_provider
  ]
}
