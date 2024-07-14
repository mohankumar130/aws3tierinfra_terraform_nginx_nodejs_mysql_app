resource "aws_vpc" "vpc_demo" {
    cidr_block =  var.cidr_block["vpc_cidr"]
    tags = {
    Name = "demo_vpc"
  }
}

resource "aws_subnet" "pub_sn1" {
      vpc_id = aws_vpc.vpc_demo.id
      cidr_block = var.cidr_block["sn1"]
      map_public_ip_on_launch = true
      availability_zone = var.az[0]
      tags = {
      Name = "${var.tag_name[0]}-${"sn1"}"
    }
}

resource "aws_subnet" "pub_sn2" {
  vpc_id = aws_vpc.vpc_demo.id
  cidr_block = var.cidr_block["sn2"]
  map_public_ip_on_launch = true
  availability_zone = var.az[1]
  tags = {
      Name = "${var.tag_name[0]}-${"sn2"}"
    }
}

resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.vpc_demo.id
    cidr_block = var.cidr_block["sn3"]
    availability_zone = var.az[0]
    tags = {
      Name = "${var.tag_name[1]}-${"sn1"}"
    }
}

resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.vpc_demo.id
    cidr_block = var.cidr_block["sn4"]
    availability_zone = var.az[1]
    tags = {
      Name = "${var.tag_name[1]}-${"sn2"}"
    }
}