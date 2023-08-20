output "identity_provider_url" {
  value = module.iam-tfe-oidc.identity_provider_url
}

output "audience" {
  value = module.iam-tfe-oidc.audience
}

output "role_arns" {
  value = module.iam-tfe-oidc.role_arns
}