#
# Public Subnet
#
# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "subnet_public" {
  count = "${length(var.availability_zones)}"

  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${element(var.public_subnet_cidr, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags = "${var.subnet_public_tags}"
}

output "public_subnet_ids" {
  value = [ "${aws_subnet.subnet_public.*.id}" ]
}



# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "subnet_public" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
  tags = "${var.route_table_subnet_public_tags}"
}



# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "subnet_public" {
  count = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.subnet_public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.subnet_public.*.id, count.index)}"
}
