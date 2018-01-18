#
# Bastion Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_ssh_for_bastion" {
  name        = "tf_ssh_for_bastion"
  description = "Allow SSH to Bastion host from approved IP ranges"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.trusted_ip_range}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "tf_ssh_for_bastion"
  }
}

output "sg_ssh_for_bastion_id" {
  value = "${aws_security_group.sg_ssh_for_bastion.id}"
}

resource "aws_security_group" "sg_ssh_from_bastion" {
  name        = "tf_ssh_from_bastion"
  description = "Allow SSH from Bastion host"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.sg_ssh_for_bastion.id}",
      "${var.nat_sg_id}",
    ]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "tf_ssh_from_bastion"
  }
}

output "sg_ssh_from_bastion_id" {
  value = "${aws_security_group.sg_ssh_from_bastion.id}"
}
