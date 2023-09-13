#this file consists of code for instances and sg
provider "aws" {
region = "us-east-1"
}

resource "aws_instance" "one" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte  server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_instance" "five" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1a"
  tags = {
    Name = "db-server-1"
  }
}

resource "aws_instance" "six" {
  ami             = "ami-0f844a9675b22ea32"
  instance_type   = "t2.micro"
  key_name        = "Ansible"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "us-east-1b"
  tags = {
    Name = "db-server-2"
  }
}

resource "aws_security_group" "seven" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "eight" {
  bucket = "terraserverbucketoo99"
}

resource "aws_iam_user" "nine" {
for_each = var.user_names
name = each.value
}

variable "user_names" {
description = "*"
type = set(string)
default = ["user1", "user2", "user3", "user4"]
}

resource "aws_ebs_volume" "ten" {
 availability_zone = "us-east-1a"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
