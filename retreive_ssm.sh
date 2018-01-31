#!/bin/bash -eux

# This script exists until Ansible is able to natively read from the
# AWS SSM Parameter Store.
# https://docs.ansible.com/ansible/devel/module_docs/aws_ssm_parameter_store_module.html
# As of 2018-01-30, the aws_ssm_parameter_store module can only write, edit,
# and delete keys

# install ansible
sudo pip install ansible

# retrieve SSM Parameter Store secret values
RDS_PASSWORD=$(aws ssm get-parameters --name "/rds/database_password" --with-decryption \
  --query "Parameters[].Value"  --output text);

ELK_PRIVATE_IP=$(aws ssm get-parameters --name "/elk/elk-ec2_private_ip" --with-decryption \
  --query "Parameters[].Value"  --output text);


# download the packer-aws-base project
git clone https://github.com/apolloclark/packer-aws-base
cd packer-aws-base/ansible



# update the requirements.html
cat <<EOF > requirements.yml
---
- src: apolloclark.filebeat           # https://github.com/apolloclark/ansible-role-filebeat
- src: apolloclark.metricbeat         # https://github.com/apolloclark/ansible-role-metricbeat
- src: apolloclark.heartbeat          # https://github.com/apolloclark/ansible-role-heartbeat
- src: apolloclark.packetbeat         # https://github.com/apolloclark/ansible-role-packetbeat
EOF



# change the playbook
cat <<EOF > playbook.yml
---
# playbook.yml

- hosts: localhost
  connection: local
  gather_facts: yes
  become: true
  vars_files:
    - "vars.yml"
  roles:
    - apolloclark.filebeat
    - apolloclark.metricbeat
    - apolloclark.heartbeat
    - apolloclark.packetbeat

EOF



# output all the variables
cat <<EOF > vars.yml
---
hostname: all

# apolloclark/filebeat
filebeat:
 version: "5.6.5"
 output:
   elasticsearch:
     enabled: "true"
     hosts: '["http://$ELK_PRIVATE_IP:9200"]'

# apolloclark/metricbeat
metricbeat:
 version: "5.6.5"
 output:
   elasticsearch:
     enabled: "true"
     hosts: '["http://$ELK_PRIVATE_IP:9200"]'

# apolloclark/heartbeat
heartbeat:
 version: "5.6.5"
 output:
   elasticsearch:
     enabled: "true"
     hosts: '["http://$ELK_PRIVATE_IP:9200"]'

# apolloclark/packetbeat
packetbeat:
  version: "5.6.5"
  protocols:
    http:
      enabled: "true"
      ports: '[80]'
  output:
   elasticsearch:
     enabled: "true"
     hosts: '["http://$ELK_PRIVATE_IP:9200"]'
EOF



# download the ansible playbooks into the "roles" folder
ansible-galaxy install --force -v --roles-path='./roles' --role-file='./requirements.yml'

# run the playbook, against localhost
ansible-playbook playbook.yml

# cd ../

# export PACKER_BUILDER='amazon-ebs'; export AMI_NAME='{{ user `ami_name` }}'; export SSH_PRIVATE_KEY_FILE='{{ user `ssh_private_key_file` }}'; rake spec",
