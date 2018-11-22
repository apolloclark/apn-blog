#!/bin/bash -eux
start=`date +%s`

# remove old OVF file
rm -rf ./output/vbox

packer validate packer_virtualbox.json

packer inspect packer_virtualbox.json

packer build packer_virtualbox.json

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
