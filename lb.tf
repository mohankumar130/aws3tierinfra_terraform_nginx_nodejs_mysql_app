resource "aws_lb" "demo_lb" {
    name = "applb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.lb_sg.id ]
    subnet_mapping {
      subnet_id = aws_subnet.pub_sn1.id
    }
    subnet_mapping {
      subnet_id = aws_subnet.pub_sn2.id
    }
}

resource "aws_lb_listener" "demo_lb" {
    load_balancer_arn = aws_lb.demo_lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.app_tg.arn
    }
}