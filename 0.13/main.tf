provider "aws" {
  region = "eu-west-1"
}

variable "env" {
  default = "dev"
}

variable "prod_owner" {
  default = "leawn"
}

variable "noprod_owner" {
  default = "smbdy else"
}

variable "ec2_size" {
  default = {
      "prod" = "t2.medium"
      "dev" = "t3.micro"
      "staging" = "t3.small"
   }
}

variable "allow_port_list" {
  default = {
      "prod" = ["80", "443"]
      "dev" = ["80", "443", "8080", "22"]
  }
}

resource "aws_instance" "my_webserver2" {
  count         = var.env == "dev" ? 1 : 0
  ami           = ""
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_webserver" {
  count         = var.env == "dev" ? 1 : 0
  ami           = ""
  instance_type = var.env == "prod" ? "t2.large" : "t3.micro"

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}