locals {
  repositories = { for i in var.repositories : i.name =>
    {
      uuid = i.uuid
      envs = { for j, l in i.environment_names : l => i.environment_uuids[j] }
    }
  }

  repo_wildcards           = { for i, k in local.repositories : i => ["${k.uuid}:*"] }
  repo_wildcards_with_envs = { for i, k in local.repositories : i => [for j, l in k.envs : "${k.uuid}*:${l}*"] }

  wildcards = { for i, k in local.repositories : i => coalescelist(local.repo_wildcards_with_envs[i], local.repo_wildcards[i]) }

  iam_roles = { for i in var.repositories : i.name =>
    {
      iam_policy_arns = concat([aws_iam_policy.sts-assume-role.arn], i.iam_role_additional_policy_arns)
  } }
}