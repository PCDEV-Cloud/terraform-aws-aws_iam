output "identity_provider_url" {
  value       = aws_iam_openid_connect_provider.this.url
  description = "The URL of the identity provider."
}

output "audience" {
  value       = element(tolist(aws_iam_openid_connect_provider.this.client_id_list), 0)
  description = "The identity provider's client ID (audience)."
}

output "role_arns" {
  value       = [for i, k in aws_iam_role.assumable-with-oidc : k.arn]
  description = "A list of assumable OIDC IAM role ARNs."
}