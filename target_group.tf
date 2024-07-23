resource "aws_lb_target_group" "app_tg" {
    name = var.lb_details["lb_name_tg"]
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc_demo.id
    
}

resource "aws_lb_target_group_attachment" "app_tg_attach" {
    count = length(local.instance_ids)
    target_group_arn = aws_lb_target_group.app_tg.arn
    target_id = aws_instance.frontend_server.id
}
