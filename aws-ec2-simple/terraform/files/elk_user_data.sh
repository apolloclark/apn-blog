#!/bin/bash -ex

# set the HOME variable, https://github.com/ansible/ansible/issues/31617
export HOME=/root
cd /root

# download the packer-aws-elk-monitoring project
git clone https://github.com/apolloclark/packer-elk
cd ./packer-elk/config/ansible

# download the ansible playbooks into the "roles" folder
ansible-galaxy install --force -v --roles-path='./roles' --role-file='./requirements.yml'

# run the playbook, against localhost
ansible-playbook playbook.yml

# run serverspec tests
cd ../serverspec
source /home/root/.rvm/scripts/rvm
rake spec
