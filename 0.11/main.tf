provider "aws" {
  region = "eu-west-1"
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }

  depends_on = [
    null_resource.command1
  ]
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command = "print('Wassup')"
    interpreter = [
      "python", "-c"
    ]
  }

  depends_on = [
    null_resource.command2
  ]
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      NAME1 = "SMTH"
      NAME2 = "YUP"
      NAME3 = "NOP"
     }
  }
}

resource "aws_instance" "server" {
  ami = "smth"
  instance_type = "t3.micro"

  provisioner "local-exec" {
    command = "echo that's the command from aws_instance"
  }
}