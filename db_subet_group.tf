resource "aws_db_subnet_group" "project_rds1_sngroup" {
    name = "project_rds_subnetgroup" 
    description = "demo"
    subnet_ids = [ 
        aws_subnet.private_subnet1.id,
        aws_subnet.private_subnet2.id
     ]     
}