#!/usr/bin/env bash
echo "Building base Ubuntu 18.04.4 image..."
packer build -var-file=vars.common.json -var-file=ubuntu18044/vars.json -force -on-error=ask ubuntu18044/build.json

echo "Building base Kubernetes image..."
packer build -var-file=vars.common.json -var-file=kube/vars.json -force -on-error=ask kube/build.json