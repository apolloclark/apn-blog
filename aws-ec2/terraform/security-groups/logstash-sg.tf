#
# Logstash Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_logstash" {
  name        = "sg_tcp_to_logstash"
  description = "Allow TCP to Logstash hosts from internal IP ranges"

  # Logstash
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
    Name = "sg_tcp_to_logstash"
  }
}

output "sg_tcp_to_logstash-id" {
  value = "${aws_security_group.sg_tcp_to_logstash.id}"
}