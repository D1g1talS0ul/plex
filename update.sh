#!/bin/bash

echo -e "Deleting GIT repo\n"
rm -rf pms-docker

echo -e "Cloning Plex Github repo\n"
git clone https://github.com/plexinc/pms-docker.git

echo -e "Copying my patch file to GIT repo\n"
cp Dockerfile.patch pms-docker/
cd pms-docker

echo -e "Applying my patch file to GIT repo\n"
git apply Dockerfile.patch

echo -e "Building Plex container image\n"
docker build -t pms-docker-nvidia:mine .
cd ..

echo -e "Running Docker compose"
#docker pull plexinc/pms-docker
docker-compose -f plex.compose stop
docker-compose -f plex.compose up --detach
