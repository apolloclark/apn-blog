#!/bin/bash -eux
global_start=`date +%s`

# go up to parent
cd ../packer

# build base image, output BEATS_AMI_ID
cd ./packer-aws-beats/base
source ./build_packer_aws.sh

# build AWS webapp image, output WEBAPP_AMI_ID
cd ../../packer-aws-webapp/base
source ./build_packer_aws.sh

# build AWS java image, output JAVA_AMI_ID
cd ../../packer-aws-java/base
source ./build_packer_aws.sh

# build AWS Kafka image, output KAFKA_AMI_ID
cd ../../packer-aws-kafka/base
source ./build_packer_aws.sh

# build AWS Logstash image, output LOGSTASH_AMI_ID
cd ../../packer-aws-logstash/base
source ./build_packer_aws.sh

# build AWS ES image, output ES_AMI_ID
cd ../../packer-aws-es/base
source ./build_packer_aws.sh

# build AWS kibana image, output KIBANA_AMI_ID
#cd ../../packer-aws-kibana/base
#source ./build_packer_aws.sh

global_end=`date +%s`
secs=$((global_end-global_start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
