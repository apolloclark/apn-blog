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

variable "vpc_id" {}
variable "private_subnet_id" {}
variable "sg_ssh_from_bastion-id" {}
variable "sg_nat-public_to_nat-private_id" {}
