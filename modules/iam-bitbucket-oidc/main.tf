data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "this" {
  url             = var.identity_provider_url
  client_id_list  = [var.audience]
  thumbprint_list = var.thumbprints

  tags = var.tags
}

data "aws_iam_policy_document" "sts-assume-role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:GetSessionToken",
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:GetFederationToken",
      "sts:GetAccessKeyInfo",
      "sts:GetCallerIdentity",
      "sts:GetServiceBearerToken",
      "sts:AssumeRoleWithWebIdentity"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "sts-assume-role" {
  name        = "STSAssumeRolePolicy"
  path        = "/"
  description = "Provides access to assume IAM roles."
  policy      = data.aws_iam_policy_document.sts-assume-role.json
  tags        = var.tags
}

data "aws_iam_policy_document" "assumable-with-oidc" {
  for_each = local.wildcards

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${trimprefix(var.identity_provider_url, "https://")}"]
    }

    condition {
      test     = "StringLike"
      variable = "${trimprefix(var.identity_provider_url, "https://")}:sub"
      values   = each.value
    }
  }
}

resource "aws_iam_role" "assumable-with-oidc" {
  for_each = local.wildcards

  name                = "Bitbucket_${each.key}_AccessRole" # ^[\w+=,.@-]{1,64}$
  description         = "Role that can be assumed using Bitbucket Pipelines with OIDC provider"
  assume_role_policy  = data.aws_iam_policy_document.assumable-with-oidc[each.key].json
  managed_policy_arns = local.iam_roles[each.key].iam_policy_arns
  tags                = var.tags
}