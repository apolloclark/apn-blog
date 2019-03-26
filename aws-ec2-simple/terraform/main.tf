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

provider "aws" {
  region = "${var.region}"
}



# Data-stores



module "network" {
  source = "./network"

  trusted_ip_range    = "${var.trusted_ip_range}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnet_cidr  = "${var.public_subnet_cidr}"

  region              = "${var.region}"
  availability_zones  = "${var.availability_zones}"
  key_name            = "${var.key_name}"

  vpc_tags = {
    Name = "tf_vpc_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
  gateway_tags = {
    Name = "tf_gateway_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
  subnet_public_tags = {
    Name = "tf_subnet_public_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
  route_table_subnet_public_tags = {
    Name = "tf_route_table_subnet_public_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
}

module "security-groups" {
  source = "./security-groups"

  trusted_ip_range       = "${var.trusted_ip_range}"
  vpc_id                 = "${module.network.vpc_id}"
  vpc_cidr               = "${var.vpc_cidr}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"

  sg_tags = {
    Name = "tf_sg_tcp_to_elk_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
}



# Identity Access
module "kms" {
  source = "./kms"

  kms_tags = {
    Name = "tf_kms_key_parameter-store_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
}

module "iam" {
  source = "./iam"
  kms_key_parameter-store_arn = "${module.kms.kms_key_parameter-store_arn}"

  iam_role_tags = {
    Name = "tf_iam_key_parameter-store_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
}



# Monitoring and Logging
module "elk" {
  source = "./ec2-eip"

  # Network
  public_subnet_ids = "${module.network.public_subnet_ids}"

  # EC2
  ami_id                           = "${var.elk_ami_id}"
  instance_type                    = "${var.elk_instance_type}"
  key_name                         = "${var.key_name}"
  user_data                        = "${var.elk_user_data}"
  iam_profile_parameter_store-name = "${module.iam.iam_profile_parameter_store-name}"
  security_group_ids               = [
    "${module.security-groups.sg_tcp_to_elk-id}"
  ]
  ec2_tags = {
    Name = "tf_ec2_elk_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
  eip_tags = {
    Name = "tf_eip_elk_${var.deploy_id}",
    Owner = "${var.tag_owner}",
    OwnerEmail = "${var.tag_owner_email}"
  }
}



# Configuration store
module "parameter-store" {
  source                     = "./parameter-store"

  # Network
  kms_key_parameter-store_id = "${module.kms.kms_key_parameter-store_id}"
  kafka_eip-private_ip       = "127.0.0.1"
}