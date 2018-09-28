#
# Webapp Security Group
#

resource "aws_security_group" "sg_http_webapp_alb_to_webapp_ec2" {
  name        = "sg_http_webapp_alb_to_webapp_ec2"
  description = "Allow HTTP between webapp-alb to webapp-ec2 instances"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [
    	"${aws_security_group.sg_http_to_webapp_alb.id}"
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
    Name = "tf_http_webapp_alb_to_webapp_ec2"
  }
}

output "sg_http_webapp_alb_to_webapp_ec2-id" {
  value = "${aws_security_group.sg_http_webapp_alb_to_webapp_ec2.id}"
}
