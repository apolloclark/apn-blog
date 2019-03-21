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

# build AWS kafka image, output KAFKA_AMI_ID
#cd ../packer-aws-kafka
#source ./build_packer_aws.sh

# build AWS logstash image, output LOGSTASH_AMI_ID
#cd ../packer-aws-logstash
#source ./build_packer_aws.sh

# build AWS elk image, output ELK_AMI_ID
cd ../../packer-aws-elk/base
source ./build_packer_aws.sh

# build AWS kibana image, output KIBANA_AMI_ID
#cd ../packer-aws-kibana
#source ./build_packer_aws.sh

# build AWS gitlab image, output GITLAB_AMI_ID
#cd ../packer-aws-gitlab
#source ./build_packer_aws.sh

# build AWS builder image, output BUILDER_AMI_ID
#cd ../packer-aws-builder
#source ./build_packer_aws.sh

# build AWS jenkins image, output JENKINS_AMI_ID
#cd ../packer-aws-jenkins
#source ./build_packer_aws.sh

# build AWS jmeter image, output JMETER_AMI_ID
#cd ../packer-aws-jmeter
#source ./build_packer_aws.sh

global_end=`date +%s`
secs=$((global_end-global_start))
printf 'runtime = %02dh:%02dm:%02ds\n' $(($secs/3600)) $(($secs%3600/60)) $(($secs%60))
