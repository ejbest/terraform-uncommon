terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.7.0"
    }
    template = {
      source  = "hashicorp/template"
      version = ">= 2.2.0"
    }
  }
}


provider "aws" {
  region     = "us-east-2"
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}
  
provider "cloudflare" {
  api_token = local.cloudflare_api_token
}
