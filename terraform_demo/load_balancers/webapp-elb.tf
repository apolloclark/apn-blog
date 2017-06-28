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

# https://www.terraform.io/docs/providers/aws/r/elb.html
resource "aws_elb" "terraform_demo_elb" {
  name = "terraform-demo-elb"
  subnets = ["${var.public_subnet_id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 10
  }
  security_groups = ["${var.elb_http_inbound_sg_id}"]
  tags {
      Name = "terraform_demo_elb"
  }
}
output "webapp_elb_name" {
  value = "${aws_elb.terraform_demo_elb.name}"
}
output "webapp_elb_security_group" {
  value = "${aws_elb.terraform_demo_elb.source_security_group}"
}
output "webapp_elb_security_group_id" {
  value = "${aws_elb.terraform_demo_elb.source_security_group_id}"
}
