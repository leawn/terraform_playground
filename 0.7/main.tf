provider "aws" {
  region = "ca-central-1"
}

data "aws_ami" "latest_ubuntu" {
  owners      = [""]
  most_recent = true
  filter {
    name   = "name"
    values = [""]
  }
}

data "aws_ami" "latest_amazon" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = [""]
  }
}

data "aws_ami" "latest_windows" {
  owners      = [""]
  most_recent = true
  filter {
    name   = "name"
    values = [""]
  }
}

resource "aws_instance" "my_webserver_ubuntu" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"
}

output "aws_ami_ubuntu_id_output" {
  value = data.aws_ami.latest_ubuntu.id
}

output "aws_ami_ubuntu_name_output" {
  value = data.aws_ami.latest_ubuntu.name
}

output "aws_ami_amazon_id_output" {
  value = data.aws_ami.latest_amazon.id
}

output "aws_ami_amazon_name_output" {
  value = data.aws_ami.latest_amazon.name
}

output "aws_ami_windows_id_output" {
  value = data.aws_ami.latest_windows.id
}

output "aws_ami_windows_name_output" {
  value = data.aws_ami.latest_windows.name
}