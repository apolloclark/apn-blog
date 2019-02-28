#
# ELK Elastic IP
#
# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "eip" {
  instance = "${aws_instance.ec2.id}"
  vpc      = true

  tags = {
    Name = "${var.eip_tag_name}"
  }
}

output "eip-id" {
  value = "${aws_eip.eip.id}"
}

output "eip-public_ip" {
  value = "${aws_eip.eip.public_ip}"
}

output "eip-private_ip" {
  value = "${aws_eip.eip.private_ip}"
}



# https://www.terraform.io/docs/providers/aws/r/eip_association.html
resource "aws_eip_association" "eip_association" {
  instance_id   = "${aws_instance.ec2.id}"
  allocation_id = "${aws_eip.eip.id}"
}