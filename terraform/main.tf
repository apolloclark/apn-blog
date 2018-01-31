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
  source             = "./network"
  key_name           = "${var.key_name}"
  
  region             = "${var.region}"
  availability_zones = "${var.availability_zones}"
  amis               = "${var.amis}"
  instance_type      = "${var.instance_type}"

  trusted_ip_range    = "${var.trusted_ip_range}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnet_cidr  = "${var.public_subnet_cidr}"
  private_subnet_cidr = "${var.private_subnet_cidr}"
}

module "kms" {
  source             = "./kms"
}

module "iam" {
  source             = "./iam"

  kms_key_parameter-store_arn = "${module.kms.kms_key_parameter-store_arn}"
}

module "db_sql" {
  source = "github.com/terraform-community-modules/tf_aws_rds"

  # RDS
  rds_engine_type         = "${var.rds_engine_type}"
  rds_engine_version      = "${var.rds_engine_version}"
  rds_instance_class      = "${var.rds_instance_class}"
  rds_instance_identifier = "${var.rds_instance_identifier}"
  rds_allocated_storage   = "${var.rds_allocated_storage}"
  db_parameter_group      = "${var.db_parameter_group}"

  # Database
  database_name     = "${var.database_name}"
  database_user     = "${var.database_user}"
  database_password = "${var.database_password}"
  database_port     = "${var.database_port}"

  # Upgrades
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  apply_immediately  = "${var.apply_immediately}"
  maintenance_window = "${var.maintenance_window}"

  # Snapshots and backups
  skip_final_snapshot   = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot = "${var.copy_tags_to_snapshot}"
  backup_window  = "${var.backup_window}"
  backup_retention_period  = "${var.backup_retention_period}"

  # Network
  rds_is_multi_az = "${var.rds_is_multi_az}"
  subnets      = "${module.network.public_subnet_ids}"
  rds_vpc_id   = "${module.network.vpc_id}"
  private_cidr = "${var.public_subnet_cidr}"
}

module "bastion" {
  source        = "./bastion"
  key_name      = "${var.key_name}"
  
  # EC2
  region        = "${var.region}"
  amis          = "${var.amis}"
  instance_type = "${var.instance_type}"

  # Network
  trusted_ip_range  = "${var.trusted_ip_range}"
  vpc_id            = "${module.network.vpc_id}"
  public_subnet_ids = "${module.network.public_subnet_ids}"
  nat_sg_id         = "${module.network.nat_sg_id}"
}

module "elk" {
  source        = "./elk"
  key_name      = "${var.key_name}"
  
  # EC2
  region        = "${var.region}"
  elk_ami_id    = "${var.elk_ami_id}"
  instance_type = "${var.instance_type}"
  iam_profile_parameter-store_name = "${module.iam.iam_profile_parameter-store_name}"

  # Network
  trusted_ip_range = "${var.trusted_ip_range}"
  vpc_id           = "${module.network.vpc_id}"
  vpc_cidr         = "${var.vpc_cidr}"
  public_subnet_ids = "${module.network.public_subnet_ids}"
  sg_ssh_from_bastion_id = "${module.bastion.sg_ssh_from_bastion_id}"
  nat_sg_id        = "${module.network.nat_sg_id}"
}

module "parameter-store" {
  source                     = "./parameter-store"
  kms_key_parameter-store_id = "${module.kms.kms_key_parameter-store_id}"
  database_password          = "${var.database_password}"
  elk-ec2_private_ip         = "${module.elk.elk-ec2_private_ip}"
}

module "webapp" {
  source             = "./webapp"
  key_name           = "${var.key_name}"
  
  # EC2
  region             = "${var.region}"
  webapp_ami_id      = "${var.webapp_ami_id}"
  instance_type      = "${var.instance_type}"
  availability_zones = "${var.availability_zones}"
  iam_profile_parameter-store_name = "${module.iam.iam_profile_parameter-store_name}"

  # Network Settings
  vpc_id                = "${module.network.vpc_id}"
  public_subnet_ids     = "${module.network.public_subnet_ids}"
  private_subnet_id     = "${module.network.private_subnet_id}"
  sg_ssh_from_bastion_id = "${module.bastion.sg_ssh_from_bastion_id}"

  # Auto-scaling Group
  asg_min     = "${var.asg_min}"
  asg_max     = "${var.asg_max}"
  asg_desired = "${var.asg_desired}"
}

module "network-private" {
  source        = "./network-private"
  key_name      = "${var.key_name}"
  
  # EC2
  region        = "${var.region}"
  amis          = "${var.amis}"
  instance_type = "${var.instance_type}"

  # Network
  vpc_id                          = "${module.network.vpc_id}"
  private_subnet_id               = "${module.network.private_subnet_id}"
  sg_ssh_from_bastion_id          = "${module.bastion.sg_ssh_from_bastion_id}"
  sg_nat-public_to_nat-private_id = "${module.network.sg_nat-public_to_nat-private_id}"
}
