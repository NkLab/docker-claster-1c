#!/bin/bash

docker build \
	"$@" \
	--build-arg ONEC_VERSION=8.3.20.2184 \
	-t niko-lab/onec-server:8.3.20.2184 \
	-f ./server/Dockerfile .
    