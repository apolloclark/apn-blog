#
# Public Subnet
#
# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "subnet_public" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, 0)}"

  tags {
    Name = "tf_subnet_public"
  }
}

output "public_subnet_id" {
  value = "${aws_subnet.subnet_public.id}"
}



# https://www.terraform.io/docs/providers/aws/r/route_table.html
resource "aws_route_table" "subnet_public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "tf_public_subnet_route_table"
  }
}



resource "aws_route_table_association" "subnet_public" {
  subnet_id      = "${aws_subnet.subnet_public.id}"
  route_table_id = "${aws_route_table.subnet_public.id}"
}