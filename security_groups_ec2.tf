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
resource "aws_security_group" "frontend_server_sg" {
    name = "frontend-${var.tag_name[4]}-sg"
    description = "frontend-${var.tag_name[4]}-sg"
    vpc_id = aws_vpc.vpc_demo.id
    lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
    tags = {
      Name = "frontend-${var.tag_name[4]}-sg"
    }
}
resource "aws_security_group" "backend_server_sg" {
    name = "backend-${var.tag_name[4]}-sg"
    description = "backend-${var.tag_name[4]}-sg"
    vpc_id = aws_vpc.vpc_demo.id
    lifecycle {
    ignore_changes = [
      ingress,  // Ignore changes to ingress rules
      egress,   // Ignore changes to egress rules
      description,  // Ignore changes to the description
    ]
  }
    tags = {
      Name = "backend-${var.tag_name[4]}-sg"
    }
}