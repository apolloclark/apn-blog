#!/bin/bash -eux

# set the HOME variable, https://github.com/ansible/ansible/issues/31617
export HOME=/root
source /usr/local/rvm/scripts/rvm

# download the packer-aws-bastion project
git clone https://github.com/apolloclark/packer-aws-bastion /root/packer-aws-bastion
cd /root/packer-aws-bastion/config/ansible

# download the ansible playbooks into the "roles" folder
ansible-galaxy install --force -v --roles-path='./roles' --role-file='./requirements.yml'

# run the playbook, against localhost
ansible-playbook playbook_local.yml

# run serverspec tests
cd ../
rake spec
