#
# Logstash ALB Security Group
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_logstash_alb" {
  name        = "sg_tcp_to_logstash_alb"
  description = "Allow TCP from the internal network to the logstash_alb"

  ingress {
    from_port   = 5044
    to_port     = 5044
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
    Name = "sg_tcp_to_logstash_alb"
  }
}

output "sg_tcp_to_logstash_alb-id" {
  value = "${aws_security_group.sg_tcp_to_logstash_alb.id}"
}
