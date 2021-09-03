provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_server_web" {
  ami                    = "ami-0453cb7b5f2b7fca2" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server_web.id]

  tags = {
    Name  = "Web Server"
    Owner = "leawn"
  }

  depends_on = [
    aws_instance.my_server_db,
    aws_instance.my_server_app
  ]
}

resource "aws_instance" "my_server_app" {
  ami                    = "ami-0453cb7b5f2b7fca2" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server_web.id]

  tags = {
    Name  = "Application Server"
    Owner = "leawn"
  }

  depends_on = [
    aws_instance.my_server_db
  ]
}

resource "aws_instance" "my_server_db" {
  ami                    = "ami-0453cb7b5f2b7fca2" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server_web.id]

  tags = {
    Name  = "Database Server"
    Owner = "leawn"
  }
}

resource "aws_security_group" "my_server_web" {
  name        = "Webserver"
  description = "same"

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Webserver"
    Owner = "leawn"
  }
}