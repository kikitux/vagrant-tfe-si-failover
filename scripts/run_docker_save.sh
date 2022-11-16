#!/usr/bin/env bash

images=`docker images -q`
[ "$images" ] && docker save $images -o /vagrant/dockerimages.tar
