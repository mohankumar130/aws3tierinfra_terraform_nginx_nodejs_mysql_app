resource "aws_security_group" "lb_sg" {
    name = "lb_sg"
    description = "lb_sg"
    vpc_id = aws_vpc.vpc_demo.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ var.cidr_block["any_cidr"] ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ var.cidr_block["any_cidr"] ]
    }
}