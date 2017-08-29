#
# Bastion EC2 Instance
#
resource "aws_instance" "bastion_ec2" {
  key_name      = "${var.key_name}"
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"

  subnet_id                   = "${var.public_subnet_id}"
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.sg_ssh_for_bastion.id}"]

  tags = {
    Name = "tf_bastion"
  }
}

output "bastion_ec2_id" {
  value = "${aws_instance.bastion_ec2.id}"
}
