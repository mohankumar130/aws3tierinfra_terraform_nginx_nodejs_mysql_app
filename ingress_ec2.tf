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
resource "aws_security_group_rule" "app1_ingress_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app1_server_sg.id
    description = "bastion and app2"
    cidr_blocks = [
        "${aws_instance.bastion_server.private_ip}/32", 
        "${aws_instance.app2_server.private_ip}/32" 
    ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "app2_ingress_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app2_server_sg.id
    description = "bastion and app1"
    cidr_blocks = [
        "${aws_instance.bastion_server.private_ip}/32", 
        "${aws_instance.app1_server.private_ip}/32" 
    ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
}

resource "aws_security_group_rule" "app1_lb_ingress" {
  type = var.sg_type[0]
  security_group_id = aws_security_group.app1_server_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
}

resource "aws_security_group_rule" "app2_lb_ingress" {
  type = var.sg_type[0]
  security_group_id = aws_security_group.app2_server_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
}