#
# Bastion EC2 Instance
#
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "elk-ec2" {
  key_name      = "${var.key_name}"
  ami           = "${var.elk_ami_id}"
  instance_type = "${var.instance_type}"

  subnet_id                   = "${element(var.public_subnet_ids, 0)}"
  associate_public_ip_address = true
  vpc_security_group_ids      = [
    "${aws_security_group.sg_ssh_bastion_and_elk-ec2.id}",
    "${aws_security_group.sg_http_to_elk.id}"
  ]

  tags = {
    Name = "tf_elk"
  }
}

output "elk-ec2_id" {
  value = "${aws_instance.elk-ec2.id}"
}
