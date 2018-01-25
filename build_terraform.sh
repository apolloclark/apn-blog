#!/bin/bash -eux
global_start=`date +%s`

cd ./terraform

export TF_VAR_trusted_ip_range="$(wget http://ipecho.net/plain -O - -q)/32";

export TF_VAR_elk_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep 'packer-aws-elk' | tail -1 | cut -f1);

export TF_VAR_webapp_ami_id=$(aws ec2 describe-images \
  --filter 'Name=is-public,Values=false'  \
  --query 'Images[].[ImageId, Name]' \
  --output text | sort -k2 | grep "packer-aws-web" | tail -1 | cut -f1);

printenv | grep "TF_VAR"

terraform get
terraform plan
terraform apply

terraform output -module=kms
terraform output -module=iam
terraform output -module=bastion
terraform output -module=elk

global_end=`date +%s`
secs=$((global_end-global_start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
