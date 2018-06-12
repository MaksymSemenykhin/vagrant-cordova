#!/usr/bin/env bash
source /image/provision/output.sh

ANDROID_HOME=/opt/android-sdk
mkdir -p /opt/jdk/
mkdir /opt/android-sdk
mkdir ~/.android -p
touch ~/.android/repositories.cfg
sudo cp /image/config/android-tool.cfg  ~/.android/androidtool.cfg

add-apt-repository ppa:cordova-ubuntu/ppa -y
apt-get update -yqq
apt-get install cordova-cli -yqq

print_title "JDK install"

wget  --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz -O /tmp/jdf.tar.gz
tar -xf /tmp/jdf.tar.gz  -C /opt/jdk/
export JAVA_HOME=/opt/jdk/jdk1.8.0_171
export JRE_HOME=/opt/jdk/jdk1.8.0_171

echo "export JAVA_HOME=/opt/jdk/jdk1.8.0_171" >> /etc/bash.bashrc
echo "export JRE_HOME=/opt/jdk/jdk1.8.0_171" >> /etc/bash.bashrc
source /etc/bash.bashrc



print_title "Android-sdk install"

cd $ANDROID_HOME
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
unzip -qq ./sdk-tools-linux-4333796.zip
yes | ./tools/bin/sdkmanager --licenses
bash ./tools/bin/sdkmanager --update

bash ./tools/bin/sdkmanager "build-tools;28.0.0"
bash ./tools/bin/sdkmanager "platform-tools"


PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export ANDROID_HOME=$ANDROID_HOME
echo "export ANDROID_HOME=$ANDROID_HOME" >> /etc/bash.bashrc
export PATH=$PATH:$ANDROID_HOME/bin
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platforms:$ANDROID_HOME/build-tools/28.0.8/
echo "export PATH=$PATH:$ANDROID_HOME/platforms:$ANDROID_HOME/build-tools/28.0.8/" >> /etc/bash.bashrc
source /etc/bash.bashrc














print_title "Done | android"
