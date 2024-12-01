# “Terraform in 2 Hours”  
# https://www.youtube.com/watch?v=SLB_c_ayRMo&t=5027s
# 
# Good Example for getting Started 
# in this version we are moving hard coded values out 

# provider "aws" {
#   region = local.ejb_region
# }

# Using the fetched AWS credentials in the AWS provider
resource "aws_vpc" "ejb-prod-vpc" {
  cidr_block = local.ejb_cidr_block
  tags = {
    Name = "ejb_production_vpc"
  }
}

