#
# ELK Security Group
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_to_elk" {
  name        = "sg_tcp_to_elk"
  description = "Allow TCP to ELK host from external IP ranges"

  # SSG
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.trusted_ip_range}"]
  }

  # Kibana
  ingress {
    from_port   = 5601
    to_port     = 5601
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

  tags = "${var.sg_tags}"
}

output "sg_tcp_to_elk-id" {
  value = "${aws_security_group.sg_tcp_to_elk.id}"
}