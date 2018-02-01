#!/bin/bash -e

# fix missing Apache page
mkdir -p /var/www/html/public
cp /var/www/html/index.html /var/www/html/public/index.html

# set the HOME variable
# https://github.com/ansible/ansible/issues/31617
printenv
export HOME=/root
export _system_name="Ubuntu"
source /usr/local/rvm/scripts/rvm
gem install serverspec

# download the packer-aws-elk-monitoring project
git clone https://github.com/apolloclark/packer-aws-elk-monitoring /root/packer-aws-elk-monitoring
cd /root/packer-aws-elk-monitoring/ansible

# download the ansible playbooks into the "roles" folder
ansible-galaxy install --force -v --roles-path='./roles' --role-file='./requirements.yml'

# run the playbook, against localhost
ansible-playbook playbook.yml

# run serverspec tests
cd ../
rake spec
