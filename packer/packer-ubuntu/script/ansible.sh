#!/bin/bash -eux

# Install Ansible repository
apt-get update
apt-get install -y software-properties-common
apt-add-repository ppa:ansible/ansible 2>&1

# Install Ansible.
apt-get update
apt-get install -y ansible
