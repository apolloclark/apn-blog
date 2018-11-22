#
# ELK Elastic IP
#
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "kafka_eip" {
  instance = "${aws_instance.elk_ec2.id}"
  vpc      = true

  tags = {
    Name = "tf-kafka_eip"
  }
}

output "kafka_eip-id" {
  value = "${aws_eip.kafka_eip.id}"
}

output "kafka_eip-public_ip" {
  value = "${aws_eip.kafka_eip.public_ip}"
}

output "kafka_eip-private_ip" {
  value = "${aws_eip.kafka_eip.private_ip}"
}



# https://www.terraform.io/docs/providers/aws/r/eip_association.html
resource "aws_eip_association" "elk_eip_association" {
  instance_id   = "${aws_instance.elk_ec2.id}"
  allocation_id = "${aws_eip.kafka_eip.id}"
}