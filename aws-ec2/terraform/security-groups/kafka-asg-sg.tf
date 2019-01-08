#
# Kafka ASG Security Group
#
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "sg_tcp_kafka_alb_to_kafka_asg" {
  name        = "sg_tcp_kafka_alb_to_kafka_asg"
  description = "Allow TCP from Kafka ALB to Kafka ASG"

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    security_groups = [
    	"${aws_security_group.sg_tcp_to_kafka_alb.id}"
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
    Name = "tf_tcp_kafka_alb_to_kafka_asg"
  }
}

output "sg_tcp_kafka_alb_to_kafka_asg-id" {
  value = "${aws_security_group.sg_tcp_kafka_alb_to_kafka_asg.id}"
}