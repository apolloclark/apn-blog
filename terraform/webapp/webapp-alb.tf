#
# Webapp Application Load Balancer
#

# https://aws.amazon.com/blogs/aws/new-aws-application-load-balancer/
# https://aws.amazon.com/blogs/devops/introducing-application-load-balancer-unlocking-and-optimizing-architectures/

# https://www.terraform.io/docs/providers/aws/r/alb.html
resource "aws_alb" "webapp_alb" {
  name    = "tf-webapp-alb"
  internal = false
  security_groups = ["${aws_security_group.sg_http_for_webapp_alb.id}"]
  subnets = ["${var.public_subnet_ids}"]
  tags {
    Name = "tf_webapp_alb"
  }
}

output "webapp_alb_id" {
  value = "${aws_alb.webapp_alb.id}"
}

output "webapp_alb_arn" {
  value = "${aws_alb.webapp_alb.arn}"
}

output "webapp_alb_dns" {
  value = "${aws_alb.webapp_alb.dns_name}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_target_group.html
resource "aws_alb_target_group" "webapp_alb_tg" {
  name     = "tf-webapp-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

output "webapp_alb_tg_id" {
  value = "${aws_alb_target_group.webapp_alb_tg.id}"
}

output "webapp_alb_tg_arn" {
  value = "${aws_alb_target_group.webapp_alb_tg.arn}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_listener.html
resource "aws_alb_listener" "webapp_alb_listener" {
  load_balancer_arn = "${aws_alb.webapp_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.webapp_alb_tg.arn}"
    type             = "forward"
  }
}

output "webapp_alb_listener_id" {
  value = "${aws_alb_listener.webapp_alb_listener.id}"
}

output "webapp_alb_listener_arn" {
  value = "${aws_alb_listener.webapp_alb_listener.arn}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_listener_rule.html
resource "aws_alb_listener_rule" "webapp_alb_listener_rule" {
  listener_arn = "${aws_alb_listener.webapp_alb_listener.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.webapp_alb_tg.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
