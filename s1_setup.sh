#!/bin/bash

git clone https://github.com/awolosewicz/bmv2-remote-attestation.git

# Install P4C
source /etc/lsb-release
echo "deb http://download.opensuse.org/repositories/home:/p4lang/xUbuntu_${DISTRIB_RELEASE}/ /" | sudo tee /etc/apt/sources.list.d/home:p4lang.list 
curl -fsSL https://download.opensuse.org/repositories/home:p4lang/xUbuntu_${DISTRIB_RELEASE}/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_p4lang.gpg > /dev/null 
sudo apt-get update 
sudo apt-get install -y p4lang-p4c

cd ~/bmv2-remote-attestation/; git checkout dev; ./install_deps.sh; ./autogen.sh; ./configure; make -j 4
echo "BMV2-RA Model Built"