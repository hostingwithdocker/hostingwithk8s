#!/bin/bash

apt-get update

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


apt-get update


apt-get install -y docker-ce docker-ce-cli containerd.io


docker run --rm hello-world


usermod -aG docker $USER

systemctl start docker && systemctl enable docker


cat >/etc/hosts <<EOL
# Config nodes of kubernetes net
192.168.0.109	k8snode1
192.168.0.121	k8snode2
EOL

swapoff -a
iptables -P FORWARD ACCEPT