provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}
resource "aws_key_pair" "demo_terra"{
  key_name = "demo_terra"
  public_key ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCBJl8P8V+O7tV8KD1HX8eIhTfz1gn6YN+9CN2DoiZDgMHmMG3rV6kYy8BZIPa2lOSDOVRsm6U04NKgkrcNV4ldc93pZfT2Cbo+DLebTs/FVsJYBLh5iIKptMh4HcQSu0cMJjcv0YmgBkeMngyhGhqg0QnOuAOfN0QqxlAHglKFJr70E76FE1gRTxTvsdkp5/tdIcsoE9ZfKnphPeTleOslctwBwIkFs8Voo1Adq4M5lzJtffe/MM1AuuB6RGI9ysYRSJ0V5IIWq1Chxliz/XrfcLADueZGG9adJVZnbMiSIbzOn9R7agTuZpkEMd/2MLGkJTzv46a+PKhn706Iyasp"
}
resource "aws_instance" "terraform_demo"{
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.demo_terra.key_name}"
  user_data = "${file("demo.sh")}"
}
resource "aws_vpc" "Test_Vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Test_Vpc"
  }
}
  resource "aws_subnet" "subnet_test" {
  vpc_id     = "${aws_vpc.Test_Vpc.id}"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet1"
  }
}