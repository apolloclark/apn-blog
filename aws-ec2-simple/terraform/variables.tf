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

#
# Shared
#
# keep the deploy_id 8 chars, alpha-numeric
variable "deploy_id" {
  default = "abcd1234"
}
variable "tag_owner" {
  default = "apolloc"
}
variable "tag_owner_email" {
  default = "apolloclark@gmail.com"
}
variable "key_name" {
  default = "packer"
}
variable "instance_type" {
  default = "t2.medium"
}
# Amazon Linux AMI, most recent as of 2017-06-15
variable "amis" {
  default = {
    us-east-1 = "ami-41e0b93b"
  }
}



#
# Network
#
variable "region" {
  default = "us-east-1"
}
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "trusted_ip_range" {
  default = "0.0.0.0/0" # Change to your VPN or Home IP Range!
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}



#
# ELK
#
variable "elk_ami_id" {
  default = "ami-41e0b93b"
}
variable "elk_instance_type" {
  default = "t2.xlarge"
}
variable "elk_user_data" {
  default = "../files/elk_user_data.sh"
}
