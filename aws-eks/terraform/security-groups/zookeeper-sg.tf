#
# Zookeeper Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_zookeeper" {
  name        = "sg_tcp_to_zookeeper"
  description = "Allow TCP to Zookeeper host from internal IP ranges"

  # Zookeeper
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "sg_tcp_to_zookeeper"
  }
}

output "sg_tcp_to_zookeeper-id" {
  value = "${aws_security_group.sg_tcp_to_zookeeper.id}"
}