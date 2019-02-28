#!/bin/bash -eux
global_start=`date +%s`

# go up to parent
cd ../docker/packer-elk-docker
./all.sh

global_end=`date +%s`
secs=$((global_end-global_start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
