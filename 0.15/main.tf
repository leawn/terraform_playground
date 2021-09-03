provider "aws" {
  region = "eu-west-1"
  alias  = "first"

  access_key = "xxxxxxxx"
  secret_key = "xxxxxxxx"

  assume_role {
    role_arn = "arn:aws:iam:1234567:role/RemoteAdministrators"
    session_name = "TERRAFORM_SESSION"
  }
}

provider "aws" {
  region = "eu-west-2"
  alias  = "second"
}

provider "aws" {
  region = "eu-west-3"
  alias  = "third"
}

data "aws_ami" "default_ami" {
  provider = aws.first
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "second_ami" {
  provider = aws.second
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "third_ami" {
  provider = aws.third
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "my_default_server" {
  provider      = aws.first
  instance_type = "t3.micro"
  ami           = data.aws_ami.default_ami.id
  tags = {
    Name = "default server"
  }
}

resource "aws_instance" "my_second_server" {
  provider      = aws.second
  instance_type = "t3.micro"
  ami           = data.aws_ami.second_ami.id
  tags = {
    Name = "second server"
  }
}

resource "aws_instance" "my_third_server" {
  provider      = aws.third
  instance_type = "t3.micro"
  ami           = data.aws_ami.third_ami.id
  tags = {
    Name = "third server"
  }
}