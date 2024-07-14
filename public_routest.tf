resource "aws_route" "public_route" {
    route_table_id =   aws_route_table.pub_rt.id
    destination_cidr_block = var.cidr_block["any_cidr"]
    gateway_id = aws_internet_gateway.demo_igw.id
}

