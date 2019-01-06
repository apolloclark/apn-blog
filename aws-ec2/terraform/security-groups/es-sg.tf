#
# ES Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_es" {
  name        = "sg_tcp_to_elk"
  description = "Allow TCP to ES host from internal IP ranges"
  # Elasticsearch
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Elasticsearch
  ingress {
    from_port   = 9300
    to_port     = 9300
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
    Name = "sg_tcp_to_es"
  }
}

output "sg_tcp_to_es-id" {
  value = "${aws_security_group.sg_tcp_to_es.id}"
}