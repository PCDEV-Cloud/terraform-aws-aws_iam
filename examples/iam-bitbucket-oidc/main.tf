provider "aws" {
  region = "eu-west-1"
}

module "iam-bitbucket-oidc" {
  source = "../../modules/iam-bitbucket-oidc"

  identity_provider_url = "https://api.bitbucket.org/2.0/workspaces/pcdev/pipelines-config/identity/oidc"
  audience              = "ari:cloud:bitbucket::workspace/7c8dgv46-0v64-5n37-a83u-83hh8f8e8hh8"

  repositories = [
    {
      name = "pcdev-app"
      uuid = "{fjndskjnf}"
    },
    {
      name = "pcdev-infra"
      uuid = "{kjdsllkjfsd}"
    }
  ]
}
