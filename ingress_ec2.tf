resource "aws_vpc_security_group_ingress_rule" "bastion" {
    security_group_id = aws_security_group.bastion_sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    from_port = 22
    ip_protocol = "tcp"
    to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "nat_server" {
    security_group_id = aws_security_group.nat_server-sg.id
    cidr_ipv4 = var.cidr_block["any_cidr"]
    ip_protocol = "-1"  
}

resource "aws_security_group_rule" "app1_ingress_80" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app1_server_sg.id
    from_port = 80
    protocol = "tcp"
    to_port = 80
    source_security_group_id = aws_security_group.bastion_sg.id        
}

resource "aws_security_group_rule" "app1_ingress_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app1_server_sg.id
    from_port = 22
    protocol = "tcp"
    to_port = 22
    source_security_group_id = aws_security_group.bastion_sg.id        
}
resource "aws_security_group_rule" "app1_ingress_80_any" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app1_server_sg.id
    cidr_blocks = [ var.cidr_block["any_cidr"] ]
    from_port = 80
    protocol = "tcp"
    to_port = 80            
}

resource "aws_security_group_rule" "app2_ingress_80" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app2_server_sg.id
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = [ var.cidr_block["any_cidr"] ]       
}

resource "aws_security_group_rule" "app1_to_app2_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app2_server_sg.id
    from_port = 22
    source_security_group_id = aws_security_group.app1_server_sg.id
    protocol = "tcp"
    to_port = 22        
}


resource "aws_security_group_rule" "app2_to_app1" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app1_server_sg.id
    from_port = 22
    source_security_group_id = aws_security_group.app2_server_sg.id
    protocol = "tcp"
    to_port = 22        
}
resource "aws_security_group_rule" "bastion_to_app2_22" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app2_server_sg.id
    from_port = 22
    source_security_group_id = aws_security_group.bastion_sg.id
    protocol = "tcp"
    to_port = 22 
}
resource "aws_security_group_rule" "demo_lb_to_app2" {
    type = var.sg_type[0]    
    security_group_id = aws_security_group.app2_server_sg.id
    from_port = 80
    source_security_group_id = aws_security_group.lb_sg.id
    protocol = "tcp"
    to_port = 80 
}