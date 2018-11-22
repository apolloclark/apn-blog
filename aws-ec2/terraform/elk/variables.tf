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
variable "elk_ami_id" {}
variable "instance_type" {}
variable "iam_profile_parameter_store-name" {}
variable "sg_ssh_from_bastion-id" {}
variable "sg_tcp_to_elk-id" {}

variable "trusted_ip_range" {}
variable "vpc_cidr" {}
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = "list"
}
variable "nat_sg-id" {}
