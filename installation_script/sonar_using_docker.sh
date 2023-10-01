#!/bin/bash

func() {
  docker="$(docker -v | cut -c 16-17)"
  if [ $docker -gt 19]; then
    echo "docker is install"
    sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
    docker ps
  else
    sudo apt update -y
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
    sudo apt update -y
    apt-cache policy docker-ce -y
    sudo apt install docker-ce -y
    #sudo systemctl status docker
    sudo chmod 777 /var/run/docker.sock
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
    docker ps
  fi

}

memory="$(free -g | awk 'NR==2 {print $2}')"

if [ $memory -gt 3 ];then
    echo "Memory has mimimum 4 GB RAM"
    func

else
    echo "Check your Memory size"
    echo "use minimum 4 GB RAM"
    exit 1
fi
