#!/bin/bash

memory="$(free -g | awk 'NR==2 {print $2}')"

docker="$(docker -v | cut -c 16-17)"

func() {
  if [ $docker -gt 19]; then
    echo "docker is install"
    sudo chmod 777 /var/run/docker.sock
    docker run -it --name nexus -d -p 8081:8081 nexus3
  else
    sudo apt install docker.io -y
    sudo chmod 777 /var/run/docker.sock
    docker run -it --name nexus -d -p 8081:8081 nexus3
}

if [ $memory -gt 3 ];then
    echo "Memory has mimimum 4 GB RAM"
    func

else
    echo "Check your Memory size"
    echo "use minimum 4 GB RAM"
    exit 1
fi

