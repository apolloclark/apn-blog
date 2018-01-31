#
# Webapp Launch Configuration
#
# https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html#user-data-shell-scripts
resource "aws_launch_configuration" "webapp_lc" {
  lifecycle {
    create_before_destroy = true
  }

  image_id      = "${var.webapp_ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_profile_parameter-store_name}"

  security_groups = [
    "${aws_security_group.sg_http_webapp_alb_and_webapp_ec2.id}",
    "${aws_security_group.sg_ssh_bastion_and_webapp-ec2.id}",
  ]

  user_data                   = "${file("./webapp/userdata.sh")}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = true
}

output "webapp_lc_name" {
  value = "${aws_launch_configuration.webapp_lc.name}"
}

output "webapp_lc_id" {
  value = "${aws_launch_configuration.webapp_lc.id}"
}
