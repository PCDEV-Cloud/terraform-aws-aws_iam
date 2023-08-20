provider "aws" {
  region = "eu-west-1"
}

module "iam-tfe-oidc" {
  source = "../../modules/iam-tfe-oidc"

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