#!/bin/bash -eux

# record script run time
global_start=`date +%s`

cd ./terraform

# get the user's public ip address
export TF_VAR_trusted_ip_range="$(wget http://ipecho.net/plain -O - -q)/32";

# get the newest "packer-aws-beats" AMI ID
export TF_VAR_beats_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-beats' | tail -1 | cut -f1);

# get the newest "packer-aws-es" AMI ID
export TF_VAR_es_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-es' | tail -1 | cut -f1);

# get the newest "packer-aws-kafka" AMI ID
export TF_VAR_kafka_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-kafka' | tail -1 | cut -f1);

# get the newest "packer-aws-logstash" AMI ID
export TF_VAR_logstash_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-logstash' | tail -1 | cut -f1);

# get the newest "packer-aws-webapp" AMI ID
export TF_VAR_webapp_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep "packer-aws-webapp" | tail -1 | cut -f1);

# get the newest "packer-aws-kibana" AMI ID
export TF_VAR_kibana_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-kibana' | tail -1 | cut -f1);

printenv | grep "TF_VAR"

terraform get
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

terraform output -module=bastion | grep "ip" --color=never
printf "\n"
terraform output -module=elk | grep "ip" --color=never
printf "\n"
terraform output -module=webapp | grep -F "webapp_alb-dns" --color=never
printf "\n"

# print the Private IP and Name of all running EC2 instances
aws ec2 describe-instances --filters Name=instance-state-name,Values=running \
  --query 'Reservations[].Instances[].[PrivateIpAddress, Tags[?Key==`Name`].Value | [0]]' \
  --output text | sort -k2

# print the script run time
global_end=`date +%s`
secs=$((global_end-global_start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
