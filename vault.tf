terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0" # Specify a compatible version
    }
  }
}

data "vault_generic_secret" "aws_vars" {
  path = "secret/aws/ejb"
}

data "vault_generic_secret" "aws_creds" {
  path = "secret/aws/credentials"
}

