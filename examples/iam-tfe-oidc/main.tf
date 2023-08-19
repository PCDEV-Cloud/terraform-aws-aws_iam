provider "aws" {
  region = "eu-west-1"
}

module "iam-tfe-oidc" {
  source = "../../modules/iam-tfe-oidc"

  access_configuration = [
    {
      organization = "PCDEV"
      run_phase    = "plan"
    },
    {
      organization = "PCDEV"
      workspaces   = ["WorkloadsTest", "WorkloadsStag"]
      run_phase    = "apply"
    },
    {
      organization = "PCDEV"
      workspaces   = ["WorkloadsProd"]
      run_phase    = "apply"
    }
  ]
}