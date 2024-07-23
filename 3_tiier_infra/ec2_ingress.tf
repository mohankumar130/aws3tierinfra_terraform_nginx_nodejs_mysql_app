resource "aws_vpc_security_group_ingress_rule" "bastion" {
    security_group_id = aws_security_group.bastion_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "nat_server" {
    security_group_id = aws_security_group.nat_server-sg.id
    cidr_ipv4 = var.cidr_block["vpc_cidr"]
    ip_protocol = "-1"  
}
resource "aws_security_group_rule" "frontend_server_ingress_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.frontend_server_sg.id
    description = "bastion"
    source_security_group_id = aws_security_group.bastion_sg.id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "backend_server_ingress_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.backend_server_sg.id
    description = "bastion"
    source_security_group_id = aws_security_group.bastion_sg.id
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "frontend_server_lb_ingress" {
  type = var.sg_type[0]
  security_group_id = aws_security_group.frontend_server_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
}

resource "aws_security_group_rule" "back_front_end" {
  type = var.sg_type[0]
  security_group_id = aws_security_group.backend_server_sg.id
  cidr_blocks = [ "${aws_instance.frontend_server.private_ip}/32" ]
  from_port = 22
  to_port = 22
  protocol = "tcp"
}