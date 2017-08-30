#
# Private subnet instance only accessible from the Bastion host
#
resource "aws_instance" "private_subnet_instance" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"

  tags = {
    Name = "tf_private_subnet"
  }

  subnet_id = "${var.private_subnet_id}"

  vpc_security_group_ids = [
    "${var.sg_ssh_from_bastion_id}",
    "${var.sg_nat-public_to_nat-private_id}",
  ]

  key_name = "${var.key_name}"
}
