provider "aws" {
  region = "eu-west-1"
}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  az_list = join(", ", data.aws_availability_zones.available.names)
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

resource "aws_eip" "name" {
  tags = {
    Name = "Static IP"
    Owner = var.owner
    Project = local.full_project_name
  }
}