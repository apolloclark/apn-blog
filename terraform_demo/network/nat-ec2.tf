#
# NAT EC2 Instance
#
# https://www.terraform.io/docs/providers/aws/d/instance.html
resource "aws_instance" "nat_ec2" {
  # this is a special ami preconfigured to do NAT
  ami                         = "${lookup(var.amis, var.region)}"
  availability_zone           = "${element(var.availability_zones, 0)}"
  instance_type               = "t2.small"
  key_name                    = "${var.key_name}"
  security_groups             = ["${aws_security_group.nat_sg.id}"]
  subnet_id                   = "${aws_subnet.subnet_public.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "tf_nat_instance"
  }
}

output "nat_ec2_id" {
  value = "${aws_instance.nat_ec2.id}"
}
