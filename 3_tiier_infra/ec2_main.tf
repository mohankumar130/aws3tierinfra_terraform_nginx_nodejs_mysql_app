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
resource "aws_instance" "frontend_server" {
    ami = data.aws_ami.aml2_ami.id
    instance_type = var.instancetype[0]
    vpc_security_group_ids = [ aws_security_group.frontend_server_sg.id ]
    key_name = var.key_pair
    subnet_id = aws_subnet.private_subnet1.id
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
      tags = {
        Name = "frontend-${var.tag_name[4]}"
      }
    }
    provisioner "remote-exec" {
      inline = [ 
        "sudo yum update",
        "sudo yum install nginx -y",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx",
        "sudo yum install git -y",
        "git clone https://github.com/mohankumar130/aws3tierinfra_terraform_nginx_nodejs_mysql_app.git",
        "sudo mv /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app/nodeapp.conf /etc/nginx/conf.d",
        "sudo mv /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app/shellscript.sh /home/ec2-user",
        "rm -rf /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app"
       ]
       connection {
        type        = "ssh"
        user        = "ec2-user"  # Replace with your SSH user
        private_key = file("D:/Key/terraform.pem")  # Specify the full path to your PEM key file
        host        = aws_instance.frontend_server.private_ip
        # If connecting via bastion server (replace with your bastion IP and user)
        bastion_host       = aws_instance.bastion_server.public_ip
        bastion_user       = "ec2-user"
        bastion_private_key = file("D:/Key/terraform.pem")
        }
      }    
    tags = {
      Name = "frontend-webserver-${var.tag_name[4]}"
    }
}

resource "aws_instance" "backend_server" {
    ami = data.aws_ami.aml2_ami.id
    instance_type = var.instancetype[0]
    subnet_id = aws_subnet.private_subnet2.id
    vpc_security_group_ids = [ aws_security_group.backend_server_sg.id ]
    key_name = var.key_pair
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
      tags = {
        Name = "backend-${var.tag_name[4]}"
      }
    }
    provisioner "remote-exec" {
  inline = [
    "sudo yum install git -y",
    "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash",
    "source ~/.bashrc",
    "nvm install --lts",
    "sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm",
    "sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y",
    "sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2023",
    "sudo dnf install mysql-community-client -y",
    "git clone https://github.com/mohankumar130/aws3tierinfra_terraform_nginx_nodejs_mysql_app.git",
    "mv /home/ec2-user/aws3tierinfra_terraform_nginx_nodejs_mysql_app /home/ec2-user/application",
    "mv /home/ec2-user/application/my-node-app /home/ec2-user/",
    "mv /home/ec2-user/application/database.sh /home/ec2-user/",
    "npm install -g pm2",
    "cd /home/ec2-user/my-node-app && npm init -y",
    "cd /home/ec2-user/my-node-app && npm install express body-parser mysql2 bcrypt ejs",
    "pm2 start /home/ec2-user/my-node-app/server.js --name 'loginapp'",
    "rm -rf /home/ec2-user/mysql80*",
    "rm -rf /home/ec2-user/application"
  ]

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("D:/Key/terraform.pem")
    host        = aws_instance.backend_server.private_ip

    bastion_host       = aws_instance.bastion_server.public_ip
    bastion_user       = "ec2-user"
    bastion_private_key = file("D:/Key/terraform.pem")
      }
    }
    tags = {
      Name = "backend-nodejs-${var.tag_name[4]}"
    }
}

locals {
  instance_ids = [
    aws_instance.frontend_server.id,
    aws_instance.backend_server.id
  ]
}