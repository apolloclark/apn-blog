#!/bin/bash -eux

# delete previous builds
aws ec2 describe-images --filter "Name=is-public,Values=false" \
  --query 'Images[].[ImageId, Name]' \
  --output text | grep "packer" | sort -k2 | tee /dev/tty | cut -d$'\t' -f1 | \
xargs -I {} aws ec2 deregister-image --image-id "{}"