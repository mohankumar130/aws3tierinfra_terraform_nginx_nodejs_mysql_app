resource "aws_route_table_association" "pub_rt_ass_sn1" {
      subnet_id = aws_subnet.pub_sn1.id
      route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "pub_rt_ass_sn2" {
      subnet_id = aws_subnet.pub_sn2.id
      route_table_id = aws_route_table.pub_rt.id
}
resource "aws_route_table_association" "private_rt_ass_sn1" {
      subnet_id = aws_subnet.private_subnet1.id
      route_table_id = aws_route_table.priv_rt.id
}
resource "aws_route_table_association" "private_rt_ass_sn2" {
      subnet_id = aws_subnet.private_subnet2.id
      route_table_id = aws_route_table.priv_rt.id
}