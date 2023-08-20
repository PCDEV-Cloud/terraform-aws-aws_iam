data "aws_caller_identity" "current" {}

resource "aws_iam_openid_connect_provider" "this" {
  url             = var.identity_provider_url
  client_id_list  = [var.audience]
  thumbprint_list = var.thumbprints

  tags = var.tags
}

data "aws_iam_policy_document" "assumable-with-oidc" {
  for_each = local.roles

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.site_address}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.site_address}:aud"
      values   = [var.audience]
    }

    condition {
      test     = "StringLike"
      variable = "${local.site_address}:sub"
      values   = each.value
    }
  }
}

resource "aws_iam_role" "assumable-with-oidc" {
  for_each = local.roles

  name               = "TFE_${each.key}_AccessRole" # ^[\w+=,.@-]{1,64}$
  description        = "Role that can be assumed by Terraform Cloud/Enterprise OIDC provider"
  assume_role_policy = data.aws_iam_policy_document.assumable-with-oidc[each.key].json
  # managed_policy_arns = local.iam_roles[each.key].iam_policy_arns
  tags = var.tags
}