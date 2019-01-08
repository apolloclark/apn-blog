#
# ES ALB Security Group
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_es_alb" {
  name        = "sg_tcp_to_es_alb"
  description = "Allow TCP from the internal network to the es_alb"

  ingress {
    from_port   = 9200
    to_port     = 9200
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
    Name = "sg_tcp_to_es_alb"
  }
}

output "sg_tcp_to_es_alb-id" {
  value = "${aws_security_group.sg_tcp_to_es_alb.id}"
}
