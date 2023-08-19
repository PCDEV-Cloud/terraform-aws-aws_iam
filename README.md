# AWS IAM Terraform module

## Features
1. Create IAM identity providers with set of roles and permissions for external identities, e.g. Terraform Cloud/Enterprise, Bitbucket, etc.

## Usage

`iam-bitbucket-oidc`

```hcl
module "iam-bitbucket-oidc" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/iam-bitbucket-oidc"

  # Open a Bitbucket repository and go to Repository settings -> OpenID Connect in the Pipelines section to get all the details.
  identity_provider_url = "<PROVIDER_URL>"
  audience              = "<AUDIENCE>"

  repositories = [
    {
      name = "<REPOSITORY_NAME>"
      uuid = "<REPOSITORY_UUID>"

      environment_names = [
        "Staging",
        "Production"
      ]
      environment_uuids = [
        "<ENV_UUID>",
        "<ENV_UUID>"
      ]
    }
  ]
}
```