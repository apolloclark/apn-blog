#
# Webapp Security Group
#

resource "aws_security_group" "sg_http_webapp_alb_and_webapp_ec2" {
  name        = "tf_http_webapp_alb_and_webapp_ec2"
  description = "Allow HTTP between webapp-alb and webapp-ec2 instances"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.sg_http_for_webapp_alb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "tf_http_webapp_alb_and_webapp_ec2"
  }
}

output "sg_http_webapp-alb_and_webapp_ec2_id" {
  value = "${aws_security_group.sg_http_webapp_alb_and_webapp_ec2.id}"
}



# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_ssh_bastion_and_webapp-ec2" {
  name        = "tf_ssh_bastion_and_webapp-ec2"
  description = "Allow SSH between Bastion and webapp-ec2 instances"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${var.sg_ssh_for_bastion_id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "tf_ssh_bastion_and_webapp-ec2"
  }
}

output "sg_ssh_bastion_and_webapp-ec2_id" {
  value = "${aws_security_group.sg_ssh_bastion_and_webapp-ec2.id}"
}
