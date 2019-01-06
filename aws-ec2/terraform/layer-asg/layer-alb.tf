#
# Layer-ASG Application Load Balancer
#

# https://aws.amazon.com/blogs/aws/new-aws-application-load-balancer/
# https://aws.amazon.com/blogs/devops/introducing-application-load-balancer-unlocking-and-optimizing-architectures/

# https://www.terraform.io/docs/providers/aws/r/alb.html
resource "aws_alb" "layer-asg_alb" {
  name    = "tf-layer-asg-alb"

  internal = false
  subnets = ["${var.public_subnet_ids}"]

  security_groups = ["${var.alb_sgs}"]

  tags {
    Name = "${var.alb_tag_name}"
  }
}

output "layer-asg_alb-id" {
  value = "${aws_alb.layer-asg_alb.id}"
}

output "layer-asg_alb-arn" {
  value = "${aws_alb.layer-asg_alb.arn}"
}

output "layer-asg_alb-dns" {
  value = "${aws_alb.layer-asg_alb.dns_name}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_target_group.html
resource "aws_alb_target_group" "layer-asg_alb_tg" {
  name     = "tf-layer-asg-alb-tg"

  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

output "layer-asg_alb_tg-id" {
  value = "${aws_alb_target_group.layer-asg_alb_tg.id}"
}

output "layer-asg_alb_tg-arn" {
  value = "${aws_alb_target_group.layer-asg_alb_tg.arn}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_listener.html
resource "aws_alb_listener" "layer-asg_alb_listener" {
  load_balancer_arn = "${aws_alb.layer-asg_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.layer-asg_alb_tg.arn}"
    type             = "forward"
  }
}

output "layer-asg_alb_listener-id" {
  value = "${aws_alb_listener.layer-asg_alb_listener.id}"
}

output "layer-asg_alb_listener-arn" {
  value = "${aws_alb_listener.layer-asg_alb_listener.arn}"
}



# https://www.terraform.io/docs/providers/aws/r/alb_listener_rule.html
resource "aws_alb_listener_rule" "layer-asg_alb_listener_rule" {
  listener_arn = "${aws_alb_listener.layer-asg_alb_listener.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.layer-asg_alb_tg.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
