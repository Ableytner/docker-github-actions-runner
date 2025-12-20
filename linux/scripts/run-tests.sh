#!/bin/bash

set -o nounset  # exit if unset variable is used
set -e          # exit on command error

docker container ls
container_id=$(docker run -d hello-world)
echo $container_id
docker logs $container_id
docker rm $container_id
docker container ls
