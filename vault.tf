data "vault_generic_secret" "aws_vars" {
  path = "secret/aws/ejb"
}

data "vault_generic_secret" "aws_creds" {
  path = "secret/aws/credentials"
}

data "vault_generic_secret" "cloudflare_zone_vars" {
  path = "cloudflare/cloudflare_zones"
}

data "vault_generic_secret" "cloudflare_api_tokens" {
  path = "cloudflare/cloudflare_api_tokens"
}