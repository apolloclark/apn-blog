#
# EC2 Instance
#
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "ec2" {
  subnet_id                   = "${element(var.public_subnet_ids, 0)}"
  associate_public_ip_address = true
  
  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  user_data              = "${file("${path.module}/${var.user_data}")}"
  iam_instance_profile   = "${var.iam_profile_parameter_store-name}"
  vpc_security_group_ids = ["${var.security_group_ids}"]

  tags = {
    Name = "${var.ec2_tag_name}"
  }
}

output "ec2-id" {
  value = "${aws_instance.ec2.id}"
}

output "ec2-private_ip" {
  value = "${aws_instance.ec2.private_ip}"
}