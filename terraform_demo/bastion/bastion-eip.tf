#
# Bastion Elatic IP
#
resource "aws_eip" "bastion_eip" {
  instance = "${aws_instance.bastion_ec2.id}"
  vpc      = true
}
