#
# Bastion EC2 Instance
#
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "bastion_ec2" {
  key_name      = "${var.key_name}"
  ami           = "${var.beats_ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_profile_parameter_store-name}"

  subnet_id                   = "${element(var.public_subnet_ids, 0)}"
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${var.sg_ssh_to_bastion-id}",
    "${var.sg_ssh_from_bastion-id}",
    "${var.sg_tcp_to_elk-id}"
  ]
  user_data                   = "${file("./bastion/userdata.sh")}"

  tags = {
    Name = "tf_bastion"
  }
}

output "bastion_ec2-private_ip" {
  value = "${aws_instance.bastion_ec2.private_ip}"
}

output "bastion_ec2-id" {
  value = "${aws_instance.bastion_ec2.id}"
}
