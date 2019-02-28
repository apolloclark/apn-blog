#
# Layer-ASG Auto-scaling Group
#

# http://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-register-targets.html
# http://docs.aws.amazon.com/autoscaling/latest/userguide/attach-load-balancer-asg.html#as-add-load-balancer-aws-cli
# https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
resource "aws_autoscaling_group" "layer-asg_asg" {
  name                  = "tf_layer-asg_${aws_launch_configuration.layer-asg_lc.name}"
  
  lifecycle {
    create_before_destroy = true
  }
  vpc_zone_identifier   = ["${var.public_subnet_ids}"]

  max_size              = "${var.asg_max}"
  min_size              = "${var.asg_min}"
  wait_for_elb_capacity = false
  force_delete          = true
  launch_configuration  = "${aws_launch_configuration.layer-asg_lc.id}"
  target_group_arns      = ["${aws_alb_target_group.layer-asg_alb_tg.arn}"]

  tag {
    key                 = "Name"
    value               = "${var.asg_tag_name}"
    propagate_at_launch = "true"
  }
}

output "layer-asg_asg_id" {
  value = "${aws_autoscaling_group.layer-asg_asg.id}"
}

output "layer-asg_asg_arn" {
  value = "${aws_autoscaling_group.layer-asg_asg.arn}"
}



#
# Scale Up Policy and Alarm
#
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "tf_layer-asg_scale_up"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.layer-asg_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name                = "tf-layer-asg-high-asg-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  insufficient_data_actions = []

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.layer-asg_asg.name}"
  }

  alarm_description = "EC2 CPU Utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale_up.arn}"]
}



#
# Scale Down Policy and Alarm
#
resource "aws_autoscaling_policy" "scale_down" {
  name                   = "tf_layer-asg_scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 600
  autoscaling_group_name = "${aws_autoscaling_group.layer-asg_asg.name}"
}

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name                = "tf-layer-asg-low-asg-cpu"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = "5"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "30"
  insufficient_data_actions = []

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.layer-asg_asg.name}"
  }

  alarm_description = "EC2 CPU Utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale_down.arn}"]
}
