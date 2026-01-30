#!/bin/bash -eux

echo "==> waiting for cloud-init to finish"
while [ ! -f /var/lib/cloud/instance/boot-finished ]; do
    echo 'Waiting for Cloud-Init...'
    sleep 1
done

echo "==> updating apt cache"
sudo apt-get update -qq

echo "==> upgrade apt packages"
sudo apt-get upgrade -y -qq

echo "=====> installing TDX tools"

sudo apt-get install -y \
    git 


git clone https://github.com/corvexai/tdx -b ppcie-fixes-2
cd tdx
sudo ./setup-tdx-host.sh
sudo attestation/setup-attestation-host.sh
