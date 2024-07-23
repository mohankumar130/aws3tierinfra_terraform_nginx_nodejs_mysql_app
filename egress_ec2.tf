resource "aws_vpc_security_group_egress_rule" "bastion_egress" {
    security_group_id = aws_security_group.bastion_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}
resource "aws_vpc_security_group_egress_rule" "nat_egress" {
    security_group_id = aws_security_group.nat_server-sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}
resource "aws_vpc_security_group_egress_rule" "frontend_server_egress" {
    security_group_id = aws_security_group.frontend_server_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}
resource "aws_vpc_security_group_egress_rule" "backend_server_egress" {
    security_group_id = aws_security_group.backend_server_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}