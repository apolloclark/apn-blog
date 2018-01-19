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

variable "key_name" {
  default = "vagrant"
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
variable "bastion_amis" {
  default = {
    us-east-1 = "ami-41e0b93b"
    us-east-2 = "ami-2581aa40"
  }
}
variable "base_ami_id" {
  default = "ami-41e0b93b"
}
variable "elk_ami_id" {
  default = "ami-41e0b93b"
}
variable "webapp_ami_id" {
  default = "ami-41e0b93b"
}



#
# Network
#
variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  # No spaces allowed between az names!
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

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default     = "10.0.5.0/24"
}



#
# Webapp
#
variable "asg_min" {
  default = "2"
}

variable "asg_max" {
  default = "5"
}

variable "asg_desired" {
  default = "2"
}



#
# Database - SQL
#
variable "rds_is_multi_az" {
  default = false
}

variable "rds_engine_type" {
  default = "mysql"

  # Valid types are
  # - mysql
  # - postgres
  # - oracle-*
  # - sqlserver-*
  # See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # --engine
}

variable "rds_engine_version" {
  description = "Database engine version, depends on engine type"
  default     = "5.7.17"

  # For valid engine versions, see:
  # See http://docs.aws.amazon.com/cli/latest/reference/rds/create-db-instance.html
  # --engine-version
}

variable "rds_instance_class" {
  description = "Class of RDS instance"
  default     = "db.t2.micro"

  # Valid values
  # https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
}

variable "rds_allocated_storage" {
  description = "The allocated storage, in GBs"
  default     = "10"
}

variable "rds_instance_identifier" {
  default = "tf-db-rds"
}

variable "database_name" {
  description = "The name of the database to create"
  default     = "tf_db_rds"
}

variable "database_user" {
  default     = "tf_db_user"
}

variable "database_password" {
  default     = "tf_db_password"
}
variable "database_port" {
  default = "3306"
}

variable "db_parameter_group" {
  description = "Parameter group, depends on DB engine used"

  default = "mysql5.7"
}

variable "allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Allow automated minor version upgrade"
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "skip_final_snapshot" {
  description = "If true (default), no snapshot will be made before deleting DB"
  default     = true
}

variable "copy_tags_to_snapshot" {
  description = "Copy tags from DB to a snapshot"
  default     = true
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi' UTC "
  default     = "Mon:01:00-Mon:02:00"
}

variable "backup_window" {
  description = "When AWS can run snapshot weekly, can't overlap with maintenance window"
  default     = "03:00-04:00"
}

variable "backup_retention_period" {
  description = "How long will we retain backups, in days"
  default     = 0
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {
  	name = "tf_db_rds"
  }
}
