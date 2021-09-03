provider "aws" {
  region = "eu-west-1"
}

variable "aws_users_list" {
  description = "list of iam users to create"
  default     = ["leawn_aws_user", "smbdy", "random_one", "yup"]
}

resource "aws_iam_user" "user1" {
  name = "leawn_aws_user"
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users_list)
  name  = element(var.aws_users_list, count.index)
}

output "created_iam_users" {
  value = aws_iam_user.users
}

output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_w_loop" {
  value = [
      for user in aws_iam_user.users:
      "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
      for user in aws_iam_user.users:
      user.unique_id => user.id // "afdsaslfsaaj" : "leawn"
  }
}

output "custom_if_length" { // prints list of users with 4 characters only
  value = [
      for x in aws_iam_user.users:
      x.name
      if length(x.name) == 4
  ]
}


// Prints map of InstanceID : Public IP
output "serverall" {
  value = {
      for server in aws_instance.servers:
      server.id => server.public_ip
  }
}

resource "aws_instance" "servers" {
    count = 3
  ami = ""
  instance_type = "t3.micro"
  tags = {
      Name = "Server Number ${count.index + 1}"
  }
}