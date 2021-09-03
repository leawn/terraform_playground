# My Terraform
#
# Build webserver during Bootstrap

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0453cb7b5f2b7fca2" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>Webserver with IP: $myip</h2><br>Build by Terraform!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF

  tags = {
    Name  = "Web Server built by Terraform"
    Owner = "leawn"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "Webserver Security Group"
  description = "Security Group for my webserver"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web Server Security Group"
    Owner = "leawn"
  }
}