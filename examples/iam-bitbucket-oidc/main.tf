terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.13.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "iam-bitbucket-oidc" {
  source = "../../modules/iam-bitbucket-oidc"

  identity_provider_url = "https://api.bitbucket.org/2.0/workspaces/thesoftwarehouse/pipelines-config/identity/oidc"
  audience              = "ari:cloud:bitbucket::workspace/8e8cbe54-0e71-4f36-a51e-69cc9b9a9ee9"

  repositories = [
    {
      name = "application"
      uuid = "{fjndskjnf}"
    },
    {
      name = "infrastructure"
      uuid = "{kjdsllkjfsd}"
    }
  ]
}
