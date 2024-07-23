resource "aws_route" "private_routes_nat" {
    route_table_id = aws_route_table.priv_rt.id
    network_interface_id = aws_instance.nat_server.primary_network_interface_id
    destination_cidr_block = var.cidr_block["any_cidr"]
}
