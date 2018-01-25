#
# ELK Security Groups
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_ssh_bastion_and_elk-ec2" {
  name        = "tf_ssh_bastion_and_elk-ec2"
  description = "Allow SSH:Bastion->elk-ec2, HTTP:Trusted->elk-ec2, TCP:Internal->elk-ec2"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${var.sg_ssh_from_bastion_id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "tf_ssh_bastion_and_elk-ec2"
  }
}

output "sg_ssh_bastion_and_elk-ec2_id" {
  value = "${aws_security_group.sg_ssh_bastion_and_elk-ec2.id}"
}



resource "aws_security_group" "sg_http_to_elk" {
  name        = "tf_http_to_elk"
  description = "Allow HTTP to ELK host from approved IP ranges"

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["${var.trusted_ip_range}"]
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
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
    Name = "tf_http_to_elk"
  }
}

output "sg_http_to_elk_id" {
  value = "${aws_security_group.sg_http_to_elk.id}"
}



resource "aws_security_group" "sg_tcp_to_elk" {
  name        = "tf_tcp_to_elk"
  description = "Allow TCP to ELK host from approved IP ranges"

  ingress {
    from_port   = 5044
    to_port     = 5044
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = 5601
    to_port     = 5601
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

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
    Name = "tf_tcp_to_elk"
  }
}

output "sg_tcp_to_elk_id" {
  value = "${aws_security_group.sg_tcp_to_elk.id}"
}
