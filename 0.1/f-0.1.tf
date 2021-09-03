provider "aws" {
  region     = "eu-central-1"
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t3.micro"
}