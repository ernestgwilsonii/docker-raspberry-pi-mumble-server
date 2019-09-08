#!/bin/bash

docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"
docker push ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION
docker tag ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION ernestgwilsonii/docker-raspberry-pi-mumble-server:latest
docker push ernestgwilsonii/docker-raspberry-pi-mumble-server:latest
