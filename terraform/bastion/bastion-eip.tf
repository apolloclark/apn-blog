#
# Bastion Elatic IP
#
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "bastion_eip" {
  instance = "${aws_instance.bastion-ec2.id}"
  vpc      = true
}

output "bastion-ec2_eip" {
  value = "${aws_eip.bastion_eip.public_ip}"
}
