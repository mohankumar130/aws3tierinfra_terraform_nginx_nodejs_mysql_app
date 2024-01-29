#Bastion Server
resource "aws_instance" "bastion_server" {
  ami = data.aws_ami.aml2_ami.id
  instance_type = var.instancetype[0]
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = var.key_pair
  associate_public_ip_address = true
  subnet_id = aws_subnet.pub_sn1.id 
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    tags = {
      Name = "${var.tag_name[3]}-${var.tag_name[4]}"
    }
  }
  tags = {
    Name = "${var.tag_name[3]}-${var.tag_name[4]}"
  }
}
#Nat Server
resource "aws_instance" "nat_server" {
    ami = data.aws_ami.nat_ami.id
    instance_type = var.instancetype[0]
    vpc_security_group_ids = [ aws_security_group.nat_server-sg.id ]
    key_name = var.key_pair
    associate_public_ip_address = true
    source_dest_check = false
    subnet_id = aws_subnet.pub_sn1.id
    tags = {
      Name = "${var.tag_name[5]}-${var.tag_name[4]}"
    }
}
# app1_server
resource "aws_instance" "app1_server" {
    ami = data.aws_ami.aml2_ami.id
    instance_type = var.instancetype[0]
    vpc_security_group_ids = [ aws_security_group.app1_server_sg.id ]
    key_name = var.key_pair
    subnet_id = aws_subnet.private_subnet1.id
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
      tags = {
        Name = "app1-${var.tag_name[4]}"
      }
    }
    tags = {
      Name = "app1-${var.tag_name[4]}"
    }
}

resource "aws_instance" "app2_server" {
    ami = data.aws_ami.aml2_ami.id
    instance_type = var.instancetype[0]
    subnet_id = aws_subnet.private_subnet2.id
    vpc_security_group_ids = [ aws_security_group.app2_server_sg.id ]
    key_name = var.key_pair
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
      tags = {
        Name = "app2-${var.tag_name[4]}"
      }
    }
    tags = {
      Name = "app2-${var.tag_name[4]}"
    }

}

