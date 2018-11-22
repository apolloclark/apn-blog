#
# Private Subnet
#
# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "subnet_private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, 0)}"

  tags {
    Name = "tf_subnet_private"
  }
}

output "private_subnet_id" {
  value = "${aws_subnet.subnet_private.id}"
}

# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "subnet_private" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat-ec2.id}"
  }

  tags {
    Name = "tf_private_subnet_route_table"
  }
}

resource "aws_route_table_association" "subnet_private" {
  subnet_id      = "${aws_subnet.subnet_private.id}"
  route_table_id = "${aws_route_table.subnet_private.id}"
}
