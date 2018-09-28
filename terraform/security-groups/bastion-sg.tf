#
# Bastion Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_ssh_to_bastion" {
  name        = "sg_ssh_to_bastion"
  description = "Allow SSH to Bastion host from approved IP ranges"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "sg_ssh_to_bastion"
  }
}

output "sg_ssh_to_bastion-id" {
  value = "${aws_security_group.sg_ssh_to_bastion.id}"
}



resource "aws_security_group" "sg_ssh_from_bastion" {
  name        = "sg_ssh_from_bastion"
  description = "Allow SSH from Bastion host"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.sg_ssh_to_bastion.id}",
      "${var.nat_sg-id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "sg_ssh_from_bastion"
  }
}

output "sg_ssh_from_bastion-id" {
  value = "${aws_security_group.sg_ssh_from_bastion.id}"
}
