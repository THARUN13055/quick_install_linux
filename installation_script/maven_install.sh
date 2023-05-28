#!/bin/bash

# to install java
_java="$JAVA_HOME/bin/java"
if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$version" >= 17.* ]]; then
        echo "Java version is enough"
        sudo apt install maven
    else
        sudo apt update -y
        sudo apt install openjdk-17-jdk -y
        sudo apt install maven
    fi
fi

i
