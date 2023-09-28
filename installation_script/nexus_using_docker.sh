#!/bin/bash

docker="$(docker -v | cut -c 16-17)"
if [ $docker -gt 19]; then
  echo "docker is install"
  sudo chmod 777 /var/run/docker.sock
  docker run -it --name nexus -d -p 8081:8081 nexus3
else
  sudo apt install docker.io -y
  sudo chmod 777 /var/run/docker.sock
  docker run -it --name nexus -d -p 8081:8081 nexus3