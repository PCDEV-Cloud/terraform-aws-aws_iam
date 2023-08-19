output "role_arns" {
  value       = [for i, k in aws_iam_role.assumable-with-oidc : k.arn]
  description = "description"
}