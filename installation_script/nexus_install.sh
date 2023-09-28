#!/bin/bash


# java installation
# nexus will support only java 8

_java="$JAVA_HOME/bin/java"

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    if [[ "$version" == 1.8.* ]]; then
        echo "Java version 8 is installed"
    else
        sudo apt update -y
        sudo apt install openjdk-8-jdk -y
    fi
fi


# nexus installation

echo "Install Nexus"

wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

sudo apt install tar -y

tar -xf latest-unix.tar.gz

cd ./nexus*/bin

chmod +x nexus

echo $(./nexus start)

echo "====================================PASSWORD====================================="
echo ""
echo ""
echo ""
sudo cat /opt/nexus/sonatype-work/nexus3/admin.password
echo ""
echo ""
echo ""
echo "====================================END========================================"
echo ""
echo ""
echo "==============================IF ERROR OCCURS=================================="
echo ""
echo ""
echo "if password will not occurs Don't run this file again copy and past this cat command "
echo ""
echo "cat /opt/nexus/sonatype-work/nexus3/admin.password"
echo ""
echo ""
echo "=====================================END====================================="