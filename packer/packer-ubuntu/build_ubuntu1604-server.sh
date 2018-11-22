#!/bin/bash -eux
start=`date +%s`

# remove old OVF file
rm -rf ./output/vbox
rm -rf ./box/virtualbox

packer build -only=virtualbox-iso \
	-var-file=ubuntu1604.json \
	-var 'update=true' \
	-var "iso_path=./iso" \
	ubuntu.json

end=`date +%s`
secs=$((end-start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
