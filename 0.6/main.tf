provider "aws" {}

data "aws_availability_zones" "available_zones" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "current" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}

output "aws_available_zones" {
  value = data.aws_availability_zones.available_zones.names[1]
}

output "aws_caller_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region_description" {
  value = data.aws_region.current.description
}

output "aws_vpcs" {
  value = data.aws_vpcs.current.ids
}

output "aws_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "aws_vpc_cidr_block" {
  value = data.aws_vpc.prod_vpc.cidr_block
}

resource "aws_subnet" "prod_subnet-1" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  cidr_block        = "10.10.1.0/24"
  tags = {
    Name    = "Subnet-1 in ${data.aws_availability_zones.available_zones.names[0]}"
    Account = "Subnet-1 in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}

resource "aws_subnet" "prod_subnet-2" {
  vpc_id            = data.aws_vpc.prod_vpc.id
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  cidr_block        = "10.10.2.0/24"
  tags = {
    Name    = "Subnet-2 in ${data.aws_availability_zones.available_zones.names[1]}"
    Account = "Subnet-2 in Account ${data.aws_caller_identity.current.account_id}"
    Region  = data.aws_region.current.description
  }
}