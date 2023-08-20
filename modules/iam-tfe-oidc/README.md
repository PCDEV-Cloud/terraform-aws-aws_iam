# AWS Terraform Cloud/Enterprise OIDC Provider

Terraform module which creates OIDC provider and access roles for Terraform Cloud/Enterprise projects and workspaces.

## Usage

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