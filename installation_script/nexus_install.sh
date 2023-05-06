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

sudo useradd -M -d /opt/nexus -s /bin/bash -r nexus

#echo "nexus ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/nexus

sudo mkdir /opt/nexus

wget https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.29.2-02-unix.tar.gz

sudo tar xzf nexus-3.29.2-02-unix.tar.gz -C /opt/nexus --strip-components=1

sudo chown -R nexus:nexus /opt/nexus

sudo sh -c 'echo "-Xms2703m\n-Xmx2703m\n-XX:MaxDirectMemorySize=2703m\n-XX:+UnlockDiagnosticVMOptions\n-XX:+LogVMOutput\n-XX:LogFile=../sonatype-work/nexus3/log/jvm.log\n-XX:-OmitStackTraceInFastThrow\n-Djava.net.preferIPv4Stack=true\n-Dkaraf.home=.\n-Dkaraf.base=.\n-Dkaraf.etc=etc/karaf\n-Djava.util.logging.config.file=etc/karaf/java.util.logging.properties\n-Dkaraf.data=./sonatype-work/nexus3\n-Dkaraf.log=./sonatype-work/nexus3/log\n-Djava.io.tmpdir=./sonatype-work/nexus3/tmp\n-Dkaraf.startLocalConsole=false\n-Djdk.tls.ephemeralDHKeySize=2048\n-Djava.endorsed.dirs=lib/endorsed" > /opt/nexus/bin/nexus.vmoptions'

sudo sh -c 'echo run_as_user="nexus" > /opt/nexus/bin/nexus.rc'

sudo -u nexus /opt/nexus/bin/nexus start

ss -altnp | grep 8081

sudo sh -c 'echo "\n[Unit]\nDescription=nexus service\nAfter=network.target\n\n[Service]\nType=forking\nLimitNOFILE=65536\nExecStart=/opt/nexus/bin/nexus start\nExecStop=/opt/nexus/bin/nexus stop\nUser=nexus\nRestart=on-abort\n\n[Install]\nWantedBy=multi-user.target\n" >> /etc/systemd/system/nexus.service'

sudo systemctl daemon-reload

sudo systemctl start nexus

sudo systemctl enable nexus

echo "==============================================================================="
echo ""
echo ""
echo ""
sudo cat /opt/nexus/sonatype-work/nexus3/admin.password
echo ""
echo ""
echo ""
echo "==============================================================================="