resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.vpc_demo.id
    tags = {
      Name = "${var.tag_name[0]}-${"rt"}"
    }
}
resource "aws_route_table" "priv_rt" {
    vpc_id = aws_vpc.vpc_demo.id
    tags = {
      Name = "${var.tag_name[1]}-${"rt"}"
    }
}