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
  source = "./network"

  trusted_ip_range    = "${var.trusted_ip_range}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnet_cidr  = "${var.public_subnet_cidr}"
  private_subnet_cidr = "${var.private_subnet_cidr}"
  
  region              = "${var.region}"
  availability_zones  = "${var.availability_zones}"
  amis                = "${var.amis}"
  instance_type       = "${var.instance_type}"
  key_name            = "${var.key_name}"
  
  vpc_tags            = {
     "Name", "tf-eks",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
  }
  subnet_tags         = {
     "Name", "tf-eks",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
  }
  internet_gateway_tags = {}
}

module "security-groups" {
  source = "./security-groups"

  trusted_ip_range       = "${var.trusted_ip_range}"
  vpc_id                 = "${module.network.vpc_id}"
  vpc_cidr               = "${var.vpc_cidr}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"
  nat_sg-id              = "${module.network.nat_sg-id}"
  
  eks_sg_tags            = {
     "Name", "tf-eks",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
  }
}

module "network-private" {
  source = "./network-private"

  # Network
  vpc_id                          = "${module.network.vpc_id}"
  private_subnet_id               = "${module.network.private_subnet_id}"
  sg_ssh_from_bastion-id          = "${module.security-groups.sg_ssh_from_bastion-id}"
  sg_nat-public_to_nat-private_id = "${module.network.sg_nat-public_to_nat-private_id}"
  
  # EC2
  region        = "${var.region}"
  amis          = "${var.amis}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
}

module "kms" {
  source = "./kms"
}

module "iam" {
  source = "./iam"
  kms_key_parameter-store_arn = "${module.kms.kms_key_parameter-store_arn}"
}



# Data-stores
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
  apply_immediately           = "${var.apply_immediately}"
  maintenance_window          = "${var.maintenance_window}"

  # Snapshots and backups
  skip_final_snapshot      = "${var.skip_final_snapshot}"
  copy_tags_to_snapshot    = "${var.copy_tags_to_snapshot}"
  backup_window            = "${var.backup_window}"
  backup_retention_period  = "${var.backup_retention_period}"

  # Network
  rds_is_multi_az = "${var.rds_is_multi_az}"
  subnets         = "${module.network.public_subnet_ids}"
  rds_vpc_id      = "${module.network.vpc_id}"
  private_cidr    = "${var.public_subnet_cidr}"
}



# Configuration store
module "parameter-store" {
  source                     = "./parameter-store"

  # Network
  kms_key_parameter-store_id = "${module.kms.kms_key_parameter-store_id}"
  database_password          = "${var.database_password}"
  kafka_eip-private_ip       = "${module.kafka.layer-asg_alb-dns}"
  logstash_eip-private_ip    = "${module.logstash.layer-asg_alb-dns}"
  es_eip-private_ip          = "${module.es.layer-asg_alb-dns}"
}



# Services
module "eks-master" {
  source                        = "./eks"
  cluster_name                  = "tf_eks_cluster"
  iam_role_parameter_store-arn  = "${module.parameter-store-iam.iam_role_parameter_store-arn}"
  public_subnet_ids             = "${module.network.public_subnet_ids}"
  security_group_ids            = "${module.network.nat_sg-id}"
}

module "eks-cluster" {
  source  = "./layer-asg"

  # Network
  vpc_id                 = "${module.network.vpc_id}"
  availability_zones     = "${var.availability_zones}"
  public_subnet_ids      = "${module.network.public_subnet_ids}"
  private_subnet_id      = "${module.network.private_subnet_id}"

  # EC2
  ami_id                            = "${var.webapp_ami_id}"
  region                            = "${var.region}"
  instance_type                     = "${var.webapp_instance_type}"
  key_name                          = "${var.key_name}"
  user_data                         = "${var.webapp_user_data}"
  iam_profile_parameter_store-name  = "${module.iam.iam_profile_parameter_store-name}"
  layer_tag_name                    = "tf_layer-asg_webapp"
  alb_sgs                           = [
  	"${module.security-groups.sg_http_to_webapp_alb-id}"
  ]
  lc_sgs                            = [
    "${module.security-groups.sg_ssh_from_bastion-id}",
    "${module.security-groups.sg_tcp_to_kafka_alb-id}",
    "${module.security-groups.sg_http_webapp_alb_to_webapp_asg-id}"
  ]

  # Auto-scaling Group
  asg_min     = "${var.webapp_asg_min}"
  asg_max     = "${var.webapp_asg_max}"
  asg_desired = "${var.webapp_asg_desired}"
}