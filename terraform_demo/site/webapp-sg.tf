# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "webapp_http_inbound_sg" {
  name = "terraform_demo_webapp_http_inbound"
  description = "Allow HTTP from Everywhere"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb_http_inbound_sg.id}"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_demo_webapp_http_inbound"
  }
}
output "webapp_http_inbound_sg_id" {
  value = "${aws_security_group.webapp_http_inbound_sg.id}"
}



# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "webapp_ssh_inbound_sg" {
  name = "terraform_demo_webapp_ssh_inbound"
  description = "Allow SSH from Bastion"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.bastion_ssh_sg.id}"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_demo_webapp_ssh_inbound"
  }
}
output "webapp_ssh_inbound_sg_id" {
  value = "${aws_security_group.webapp_ssh_inbound_sg.id}"
}



# https://www.terraform.io/docs/providers/aws/r/security_group.html
resource "aws_security_group" "webapp_outbound_sg" {
  name = "terraform_demo_webapp_outbound"
  description = "Allow outbound connections"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.default.id}"
  tags {
      Name = "terraform_demo_webapp_outbound"
  }
}
output "webapp_outbound_sg_id" {
  value = "${aws_security_group.webapp_outbound_sg.id}"
}
