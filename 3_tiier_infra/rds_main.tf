resource "aws_db_instance" "project_rds1" {
  identifier             = "${var.tag_name[2]}-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.39"
  instance_class         = var.rds_instancetype[0]
  vpc_security_group_ids = [ aws_security_group.project_rds1_sg.id ]
  db_subnet_group_name   = aws_db_subnet_group.project_rds1_sngroup.id
  username               = "root"
  multi_az               = false
  skip_final_snapshot    = true
  password               = "Finisher#0123"  # Replace with a secure password
  parameter_group_name   = "default.mysql8.0"
  
  tags = {
    Name = "${var.tag_name[2]}-db"
  }
}
