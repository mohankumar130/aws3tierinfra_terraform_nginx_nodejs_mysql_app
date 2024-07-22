resource "aws_security_group" "bastion_sg" {
  name = "${var.tag_name[3]}-${var.tag_name[4]}-sg"
  description = "${var.tag_name[3]}-${var.tag_name[4]}-sg"
  vpc_id = aws_vpc.vpc_demo.id
  lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
  tags = {
    Name = "${var.tag_name[3]}-${var.tag_name[4]}-sg"
  }
}
resource "aws_security_group" "nat_server-sg" {
    name =   "${var.tag_name[5]}-${var.tag_name[4]}-sg"
    description = "${var.tag_name[5]}-${var.tag_name[4]}-sg"
    vpc_id = aws_vpc.vpc_demo.id
    lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
    tags = {
      Name = "${var.tag_name[5]}-${var.tag_name[4]}-sg"
    }
}
resource "aws_security_group" "app1_server_sg" {
    name = "app1-${var.tag_name[4]}-sg"
    description = "app1-${var.tag_name[4]}-sg"
    vpc_id = aws_vpc.vpc_demo.id
    lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
    tags = {
      Name = "app1-${var.tag_name[4]}-sg"
    }
}
resource "aws_security_group" "app2_server_sg" {
    name = "app2-${var.tag_name[4]}-sg"
    description = "app2-${var.tag_name[4]}-sg"
    vpc_id = aws_vpc.vpc_demo.id
    lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
    tags = {
      Name = "app2-${var.tag_name[4]}-sg"
    }
}