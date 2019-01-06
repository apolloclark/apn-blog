#
# Layer-ASG Launch Configuration
#
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html#user-data-shell-scripts
resource "aws_launch_configuration" "layer-asg_lc" {
  lifecycle {
    create_before_destroy = true
  }
  associate_public_ip_address = true

  image_id             = "${var.ami_id}"
  instance_type        = "${var.instance_type}"
  key_name             = "${var.key_name}"
  user_data            = "${file("${path.module}/${var.user_data}")}"
  iam_instance_profile = "${var.iam_profile_parameter_store-name}"
  security_groups      = ["${var.lc_sgs}"]
}

output "layer-asg_lc-name" {
  value = "${aws_launch_configuration.layer-asg_lc.name}"
}

output "layer-asg_lc-id" {
  value = "${aws_launch_configuration.layer-asg_lc.id}"
}
