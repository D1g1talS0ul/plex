#!/bin/bash

#echo -e "Deleting GIT repo\n"
#rm -rf pms-docker

#echo -e "Cloning Plex Github repo\n"
#git clone https://github.com/plexinc/pms-docker.git

#echo -e "Copying my patch file to GIT repo\n"
#cp Dockerfile.patch pms-docker/
cd pms-docker

#echo -e "Applying my patch file to GIT repo\n"
# created with cd pms-docker && git diff > ../Dockerfile.patch
#git apply ../Dockerfile.patch

echo -e "Building Plex container image\n"
# Rename old image encase I need to restore
docker tag pms-docker-nvidia:mine pms-docker-nvidia:$(date +%s)
#docker build --no-cache --tag pms-docker-nvidia:mine .
cd ..

echo -e "Running Docker compose"
docker-compose -f plex.compose down
docker-compose -f plex.compose build --no-cache --pull
docker-compose -f plex.compose up --detach
