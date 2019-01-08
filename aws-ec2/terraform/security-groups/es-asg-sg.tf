#
# ES ASG Security Group
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_es_alb_to_es_asg" {
  name        = "sg_tcp_to_es"
  description = "Allow TCP from ES ALB to ES ASG"

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    security_groups = [
    	"${aws_security_group.sg_tcp_to_es_alb.id}"
    ]
  }

  ingress {
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    security_groups = [
    	"${aws_security_group.sg_tcp_to_es_alb.id}"
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
    Name = "tf_tcp_es_alb_to_es_asg"
  }
}

output "sg_tcp_es_alb_to_es_asg-id" {
  value = "${aws_security_group.sg_tcp_es_alb_to_es_asg.id}"
}