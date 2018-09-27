#
# Bastion Elatic IP
#
resource "aws_eip" "elk_eip" {
  instance = "${aws_instance.elk-ec2.id}"
  vpc      = true
}

output "elk-ec2_id" {
  value = "${aws_eip.elk_eip.id}"
}

output "elk-ec2_eip" {
  value = "${aws_eip.elk_eip.public_ip}"
}



# https://www.terraform.io/docs/providers/aws/r/eip_association.html
resource "aws_eip_association" "elk_eip_association" {
  instance_id   = "${aws_instance.elk-ec2.id}"
  allocation_id = "${aws_eip.elk_eip.id}"
}