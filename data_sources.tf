provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "aml2_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5*"]
  }
}
data "aws_ami" "nat_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn-ami-vpc-nat*"]
  }
}
