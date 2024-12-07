variable "domain_name" {
  description = "Domain Name"
  type        = string
  default     = "tracker-db.com"
}

variable "ejb_private_keyname" {
  description = "Private Key"
  type        = string
  default     = "test-key.pem"
}

# Update the locals block to use the values from Vault
locals {
  # vpc
  ejb_environment       = data.vault_generic_secret.aws_vars.data["ejb_environment"]
  ejb_region            = data.vault_generic_secret.aws_vars.data["ejb_region"]
  ejb_availability_zone = data.vault_generic_secret.aws_vars.data["ejb_availability_zone"]
  ejb_instance_type     = data.vault_generic_secret.aws_vars.data["ejb_instance_type"]
  ejb_cidr_block        = data.vault_generic_secret.aws_vars.data["ejb_cidr_block"]
  ejb_ipv6_cidr_block   = data.vault_generic_secret.aws_vars.data["ejb_ipv6_cidr_block"]
  ejb_ami_id            = data.vault_generic_secret.aws_vars.data["ejb_ami_id"]
  ejb_key_name          = data.vault_generic_secret.aws_vars.data["ejb_key_name"]

  # subnet
  ejb_sub1_cidr_block   = data.vault_generic_secret.aws_vars.data["ejb_sub1_cidr_block"]
  route_cidr_block      = data.vault_generic_secret.aws_vars.data["route_cidr_block"]
  web_server_private_ip = data.vault_generic_secret.aws_vars.data["web_server_private_ip"]

  # security group
  ejb_rt_name            = data.vault_generic_secret.aws_vars.data["ejb_rt_name"]
  ejb_subnet_name        = data.vault_generic_secret.aws_vars.data["ejb_subnet_name"]
  ejb_sg_name            = data.vault_generic_secret.aws_vars.data["ejb_sg_name"]
  sg_protocol            = data.vault_generic_secret.aws_vars.data["sg_protocol"]
  sg_ingress_cidr_blocks = data.vault_generic_secret.aws_vars.data["sg_ingress_cidr_blocks"]
  sg_egress_protocol     = data.vault_generic_secret.aws_vars.data["sg_egress_protocol"]
  sg_egress_cidr_blocks  = data.vault_generic_secret.aws_vars.data["sg_egress_cidr_blocks"]
  ejb_sg_tags_name       = data.vault_generic_secret.aws_vars.data["ejb_sg_tags_name"]
  aws_eip_domain         = data.vault_generic_secret.aws_vars.data["aws_eip_domain"]

  # SSH key
  ssh_key_algorithm = data.vault_generic_secret.aws_vars.data["ssh_key_algorithm"]
  ssh_key_rsa_bits  = data.vault_generic_secret.aws_vars.data["ssh_key_rsa_bits"]

  # web server
  ejb_webserver_name = data.vault_generic_secret.aws_vars.data["ejb_webserver_name"]

  # Cloudflare data tracker-db 
  cloudflare_db_api_email = data.vault_generic_secret.cloudflare_api_tokens.data["cloudflare_tracker_db_email"]
  cloudflare_api_token = data.vault_generic_secret.cloudflare_api_tokens.data["cloudflare_tracker_db_token"]
  cloudflare_zone_id   = data.vault_generic_secret.cloudflare_zone_vars.data["tracker_db"]

#  # Cloudflare data advocatediablo 
#   cloudflare_api_email = data.vault_generic_secret.cloudflare_api_tokens.data["cloudflare_advocatediablo_email"]
#   cloudflare_api_token = data.vault_generic_secret.cloudflare_api_tokens.data["cloudflare_advocatediablo_token"]
#   cloudflare_zone_id   = data.vault_generic_secret.cloudflare_zone_vars.data["advocatediablo"]

  # common tags
  common_tags = {
    environment = local.ejb_environment
    team        = data.vault_generic_secret.aws_vars.data["team"]
    project     = data.vault_generic_secret.aws_vars.data["project"]
  }
  security_group_ingress_rules = [
    {
      description = "HTTPS traffic"
      from_port   = 443
      to_port     = 443
    },
    {
      description = "HTTP traffic"
      from_port   = 80
      to_port     = 80
    },
    {
      description = "SSH traffic"
      from_port   = 22
      to_port     = 22
    },
  ]
}
