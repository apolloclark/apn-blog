#!/bin/bash

cd ./packer-ubuntu
./build_ubuntu1604-server_virtualbox_local.sh

cd ../packer-aws-beats/base
./build_packer_virtualbox.sh

cd ../packer-aws-java/base
./build_packer_virtualbox.sh

cd ../packer-aws-elk/config
./build_packer_virtualbox_local.sh
