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

module "network" {
  source              = "./network"
  key_name            = "${var.key_name}"
  region              = "${var.region}"
  availability_zones  = "${var.availability_zones}"
  amis                = "${var.amis}"
  instance_type       = "${var.instance_type}"
  trusted_ip_range    = "${var.trusted_ip_range}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnet_cidr  = "${var.public_subnet_cidr}"
  private_subnet_cidr = "${var.private_subnet_cidr}"
}

module "bastion" {
  source            = "./bastion"
  key_name          = "${var.key_name}"
  region            = "${var.region}"
  amis              = "${var.amis}"
  instance_type     = "${var.instance_type}"
  trusted_ip_range  = "${var.trusted_ip_range}"
  vpc_id            = "${module.network.vpc_id}"
  public_subnet_id  = "${module.network.public_subnet_id}"
  nat_sg_id         = "${module.network.nat_sg_id}"
}


module "webapp" {
  source                    = "./webapp"
  key_name                  = "${var.key_name}"
  region                    = "${var.region}"
  amis                      = "${var.amis}"
  instance_type             = "${var.instance_type}"
  availability_zones        = "${var.availability_zones}"
  vpc_id                    = "${module.network.vpc_id}"
  public_subnet_id          = "${module.network.public_subnet_id}"
  private_subnet_id         = "${module.network.private_subnet_id}"
  sg_ssh_from_bastion_id    = "${module.bastion.sg_ssh_from_bastion_id}"
  asg_min                   = "${var.asg_min}"
  asg_max                   = "${var.asg_max}"
  asg_desired               = "${var.asg_desired}"
}
