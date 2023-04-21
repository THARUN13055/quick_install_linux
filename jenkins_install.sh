#!/bin/bash

# java installation
# jenkins will support only java 11 packages

_java="$JAVA_HOME/bin/java"
if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$version" == 11.* ]]; then
        echo "Java version 11 is installed"
    else
        sudo apt update -y
        sudo apt install openjdk-11-jdk -y
    fi
fi

#jenkins installation

#This jenkins LTS is update on 4/2023

if [[  /usr/bin/jenkins == $(type -p jenkins) ]]; then
	echo "jenkins is install"
else
	curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
	sudo apt-get update -y
	sudo apt-get install jenkins -y
	echo "-----------------JENKINS_ADMIN_PASSWORD----------"
	echo ""
	echo ""
	sudo cat /var/lib/jenkins/secrets/initialAdminPassword
	echo ""
	echo ""
	echo "-----------------COPY_AND_PAST-------------------"

fi
