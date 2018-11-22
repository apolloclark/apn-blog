#!/bin/bash

cd ./packer-ubuntu
./build_ubuntu1604-server_virtualbox.sh

cd ../packer-aws-beats
./build_packer_virtualbox.sh

cd ../packer-aws-java
./build_packer_virtualbox.sh

cd ../packer-aws-elk/config
./build_packer_virtualbox.sh
