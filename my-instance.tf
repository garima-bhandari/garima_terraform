provider "aws" {
access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"
region = "${var.aws_region}"
}

resource "aws_instance" "web_server" {
ami = "ami-061392db613a6357b"
instance_type = "t2.small"
tags {
Name = "my_server"
}
}
