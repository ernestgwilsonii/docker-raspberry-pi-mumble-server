# docker-raspberry-pi-mumble-server
Mumble server (in a Docker Container) for Raspberry Pi

```
############################################
# Mumble Server in Docker for Raspberry Pi #
#           REF: https://mumble_server.org #
############################################


###############################################################################
# Download the repo
cd /tmp
git clone https://github.com/ernestgwilsonii/docker-raspberry-pi-mumble-server.git
cd docker-raspberry-pi-mumble-server

# REF: 
MUMBLE_SERVER_VERSION=$(cat version.txt)
echo $MUMBLE_SERVER_VERSION
export MUMBLE_SERVER_VERSION=$MUMBLE_SERVER_VERSION

# Docker build
time docker build --build-arg MUMBLE_SERVER_VERSION=$MUMBLE_SERVER_VERSION -t ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION -f Dockerfile.armhf .

# List images and examine sizes
docker images

# Verify 
docker run -it -p 64738:64738/tcp -p 64738:64738/udp ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION
# From another ssh session:
#docker ps

# Upload to Docker Hub
docker login
docker push ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION
# Update the latest tag to point to the updated version
docker tag ernestgwilsonii/docker-raspberry-pi-mumble-server:$MUMBLE_SERVER_VERSION ernestgwilsonii/docker-raspberry-pi-mumble-server:latest
docker push ernestgwilsonii/docker-raspberry-pi-mumble-server:latest
# REF: https://hub.docker.com/r/ernestgwilsonii/docker-raspberry-pi-mumble-server
###############################################################################


###############################################################################
# First time setup #
####################
# Create bind mounted directories/files
sudo mkdir -p /opt/mumble-server/logs
sudo cp mumble-server.ini /opt/mumble-server/mumble-server.ini
sudo chmod -R a+rw /opt/mumble-server

##########
# Deploy #
##########

# Docker (without Swarm)
docker run --name mumble_server -d -v /opt/mumble-server/mumble-server.ini:/etc/mumble-server.ini -v /opt/mumble-server:/var/lib/mumble-server -v /opt/mumble-server/logs:/var/log/mumble-server -p 64738:64738/tcp -p 64738:64738/udp ernestgwilsonii/docker-raspberry-pi-mumble-server:1.3.0

# Verify
docker ps
docker logs -f mumble_server


# Deploy the stack into a Docker Swarm
docker stack deploy -c docker-compose.yml mumble_server
# docker stack rm mumble_server

# Verify
docker ps
docker service ls | grep mumble_server
docker service logs -f mumble_server_mumble-server
ls -alF /opt/mumble-server/
```
