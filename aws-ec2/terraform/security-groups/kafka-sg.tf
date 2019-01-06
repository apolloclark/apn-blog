#
# Kafka Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_kafka" {
  name        = "sg_tcp_to_elk"
  description = "Allow TCP to KAFKA host from internal IP ranges"

  # Kafka
  ingress {
    from_port   = 9092
    to_port     = 9092
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
    Name = "sg_tcp_to_kafka"
  }
}

output "sg_tcp_to_kafka-id" {
  value = "${aws_security_group.sg_tcp_to_kafka.id}"
}