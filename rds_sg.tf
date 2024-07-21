resource "aws_security_group" "project_rds1_sg" {
    name = "${var.tag_name[2]}_rds_sg"
    description = "${var.tag_name[2]}_rds_sg"
    vpc_id = aws_vpc.vpc_demo.id

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [
            "${aws_instance.app1_server.private_ip}/32",
            "${aws_instance.app2_server.private_ip}/32"
        ]
    }
}