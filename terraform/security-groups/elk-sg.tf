#
# ELK Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_elk" {
  name        = "sg_tcp_to_elk"
  description = "Allow TCP to ELK host from internal IP ranges"

  # Zookeeper
  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Logstash
  ingress {
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Kibana
  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  # Kafka
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

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
    Name = "sg_tcp_to_elk"
  }
}

output "sg_tcp_to_elk-id" {
  value = "${aws_security_group.sg_tcp_to_elk.id}"
}