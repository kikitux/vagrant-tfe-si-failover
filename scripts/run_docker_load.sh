#!/usr/bin/env bash

which docker 2>/dev/null || {
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
}

if [ -f /vagrant/dockerimages.tar ] ; then
  docker load -i /vagrant/dockerimages.tar
fi
