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
resource "aws_vpc_security_group_egress_rule" "app1_egress" {
    security_group_id = aws_security_group.app1_server_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}
resource "aws_vpc_security_group_egress_rule" "app2_egress" {
    security_group_id = aws_security_group.app2_server_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"
}