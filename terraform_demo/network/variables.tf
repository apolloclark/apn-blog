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

variable "availability_zones" {
  type = "list"
}

variable "amis" {
  type = "map"
}

variable "instance_type" {}
variable "trusted_ip_range" {}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {
  type = "list"
}
variable "private_subnet_cidr" {}
