resource "aws_internet_gateway" "demo_igw" {
    vpc_id = aws_vpc.vpc_demo.id
    tags = {
      Name = "${var.tag_name[2]}-${"igw"}"
    }
}