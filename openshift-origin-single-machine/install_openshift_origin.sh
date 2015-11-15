#!/bin/bash

sudo yum -y update
sudo yum -y install docker
sudo yum -y install git
sudo systemctl start docker
curl -L -O https://github.com/openshift/origin/releases/download/v1.0.7/openshift-origin-v1.0.7-67bb208-linux-amd64.tar.gz
mkdir origin-1.0.7
cd origin-1.0.7/
tar zxvf ../openshift-origin-v1.0.7-67bb208-linux-amd64.tar.gz

