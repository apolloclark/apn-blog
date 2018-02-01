#!/bin/bash -eux

# single-step deploy script, just to prove that it's possible ;)

# create an EC2 keypair named "packer"
aws ec2 create-key-pair --key-name packet_test --query "KeyMaterial" \
   --output text | ~/.ssh/packer.pem

# configure key file permissions
chmod 0600 ~/.ssh/packer.pem

# add the newly created key to the keychain
ssh-add ~/.ssh/packer.pem

# clone the project, and sub-modules
git clone --recurse-submodules https://github.com/apolloclark/tf-aws
cd tf-aws

# use Packer to build the AWS AMI's
./build_packer_aws.sh

# deploy AWS infrastructure with Terraform
./build_terraform.sh
