#!/usr/bin/env bash

images=`docker images -q`
if [ "$images" ] ; then
  echo INFO: we will save the docker images to dockerimages.tar
  docker save $images -o /vagrant/dockerimages.tar
fi
