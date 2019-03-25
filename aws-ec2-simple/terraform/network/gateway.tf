#
# Internet Gateway
#
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags = "${var.gateway_tags}"
}

output "gateway_id" {
  value = "${aws_internet_gateway.default.id}"
}
