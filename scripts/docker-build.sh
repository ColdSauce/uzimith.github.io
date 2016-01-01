#!/bin/sh
set -xe

if [ -e ~/cache/docker.tar ] && [ $(md5sum Dockerfile | cut -d' ' -f1) = $(cat ~/cache/dockerfile.digest) ]
then
    docker load < ~/cache/docker.tar
else
    mkdir -p ~/cache
    docker build -t middleman .
    md5sum Dockerfile | cut -d' ' -f1 > ~/cache/dockerfile.digest
    docker save middleman > ~/cache/docker.tar
fi
