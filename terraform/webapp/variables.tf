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

variable "key_name" {}
variable "region" {}

variable "amis" {
  type = "map"
}

variable "instance_type" {}

variable "availability_zones" {
  # No spaces allowed between az names!
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "vpc_id" {}
variable "public_subnet_ids" {
  type = "list"
}
variable "private_subnet_id" {}
variable "sg_ssh_for_bastion_id" {}
variable "asg_min" {}
variable "asg_max" {}
variable "asg_desired" {}
