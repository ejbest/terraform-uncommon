terraform {
  required_providers {

    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }

  }
}

provider "aws" {
  region     = local.ejb_region
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

provider "cloudflare" {
  api_token = local.cloudflare_api_token
}
