# “Terraform in 2 Hours”  
# https://www.youtube.com/watch?v=SLB_c_ayRMo&t=5027s
# 
# Good Example for getting Started 
# in this version we are moving hard coded values out 

# provider "aws" {
#   region = local.ejb_region
# }

# Using the fetched AWS credentials in the AWS provider
provider "aws" {
  region     = local.ejb_region
  access_key = data.vault_generic_secret.aws_creds.data["access_key"]
  secret_key = data.vault_generic_secret.aws_creds.data["secret_key"]
}

resource "aws_vpc" "ejb-prod-vpc" {
  cidr_block = local.ejb_cidr_block
  tags = {
    Name = "ejb_production_vpc"
  }
}

