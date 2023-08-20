# AWS IAM Terraform module

## Features
1. Create IAM identity providers with set of roles and permissions for external identities, e.g. Terraform Cloud/Enterprise, Bitbucket, etc.

## Usage

`iam-tfe-oidc`

```hcl
module "iam-tfe-oidc" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/iam-tfe-oidc"

  access_configuration = [
    {
      organization = "my-company"
      run_phase    = "plan"
    },
    {
      organization = "my-company"
      workspaces   = ["WorkloadsTest", "WorkloadsStag"]
      run_phase    = "apply"
    },
    {
      organization = "my-company"
      workspaces   = ["WorkloadsProd"]
      run_phase    = "apply"
    }
  ]
}
```

`iam-bitbucket-oidc`

```hcl
module "iam-bitbucket-oidc" {
  source = "github.com/PCDEV-Cloud/terraform-aws-aws_iam_identity_center//modules/iam-bitbucket-oidc"

  # Open a Bitbucket repository and go to Repository settings -> OpenID Connect in the Pipelines section to get all the details.
  identity_provider_url = "https://api.bitbucket.org/2.0/workspaces/my-company/pipelines-config/identity/oidc"
  audience              = "ari:cloud:bitbucket::workspace/7c8dgv46-0v64-5n37-a83u-83hh8f8e8hh8"

  repositories = [
    {
      name = "my-repository"
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