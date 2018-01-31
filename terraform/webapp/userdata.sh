#!/bin/bash -eux

# This script exists until Ansible is able to natively read from the
# AWS SSM Parameter Store.
# https://docs.ansible.com/ansible/devel/module_docs/aws_ssm_parameter_store_module.html
# As of 2018-01-30, the aws_ssm_parameter_store module can only write, edit,
# and delete keys

# fix missing Apache page
mkdir -p /var/www/html/public
cp /var/www/html/index.html /var/www/html/public/index.html

# set the HOME variable
# https://github.com/ansible/ansible/issues/31617
export HOME=/root
source ~/.profile

# install Ansible
pip install ansible

# download the packer-aws-elk-monitoring project
pwd
rm -rf ./packer-aws-elk-monitoring/
git clone https://github.com/apolloclark/packer-aws-elk-monitoring
cd packer-aws-elk-monitoring/ansible

# retrieve SSM Parameter Store secret values
ELK_PRIVATE_IP=$(aws ssm get-parameters --name "/elk/elk-ec2_private_ip" \
  --with-decryption --query "Parameters[].Value"  --output text);

# update vars_ssm.yml
cat <<EOF > vars_ssm.yml
---
hostname: all

elastic_private_ip: $ELK_PRIVATE_IP
EOF

# download the ansible playbooks into the "roles" folder
ansible-galaxy install --force -v --roles-path='./roles' --role-file='./requirements.yml'

# run the playbook, against localhost
ansible-playbook playbook.yml
