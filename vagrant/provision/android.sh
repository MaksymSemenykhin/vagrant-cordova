#!/usr/bin/env bash
source /image/provision/output.sh
source /image/provision/functions.sh

print_title "Provision-script user: `whoami` | once-as-root"

print_title "Setting vars"

yml='/image/config/vagrant-local.yml';

proxy_http=$(grep_from_yml_string $yml proxy_http)
proxy_https=$(grep_from_yml_string $yml proxy_https)

proxy_host_http=$(grep_proxy_host_from_yml_string $yml proxy_http)
proxy_host_https=$(grep_proxy_host_from_yml_string $yml proxy_https)

proxy_port_http=$(grep_proxy_port_from_yml_string $yml proxy_http)
proxy_port_https=$(grep_proxy_port_from_yml_string $yml proxy_https)



print_title "Config"

print_regular "common:"
print_info "proxy_http:$proxy_http"
print_info "proxy_https:$proxy_https"
print_info "proxy_host_http:$proxy_host_http"
print_info "proxy_host_https:$proxy_host_https"
print_info "proxy_port_http:$proxy_port_http"
print_info "proxy_port_https:$proxy_port_https"



ANDROID_HOME=/opt/android-sdk
mkdir /opt/jdk/ -p
mkdir /opt/android-sdk -p
mkdir ~/.android -p
touch ~/.android/repositories.cfg


cat >~/.android/androidtool.cfg<<EOL
http.proxyHost=${proxy_host_http}
http.proxyPort=${proxy_port_http}
https.proxyHost=${proxy_host_https}
http.proxyPort=${proxy_port_https}
EOL



add-apt-repository ppa:cordova-ubuntu/ppa -y
apt-get update -yqq
apt-get install cordova-cli -yqq

print_title "JDK install"

wget -q  --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.tar.gz -O /tmp/jdf.tar.gz
tar -xf /tmp/jdf.tar.gz  -C /opt/jdk/
export JAVA_HOME=/opt/jdk/jdk1.8.0_171
export JRE_HOME=/opt/jdk/jdk1.8.0_171

echo "export JAVA_HOME=/opt/jdk/jdk1.8.0_171" >> /etc/bash.bashrc
echo "export JRE_HOME=/opt/jdk/jdk1.8.0_171" >> /etc/bash.bashrc
source /etc/bash.bashrc



print_title "Android-sdk install"

cd $ANDROID_HOME
wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
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
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/platforms:$ANDROID_HOME/build-tools/28.0.8/
echo "export PATH=$PATH" >> /etc/bash.bashrc

cp ~/.android/androidtool.cfg /opt/jdk/jdk1.8.0_171/lib/net.properties

cat >~/.gradle/gradle.properties<<EOL
systemProp.http.proxyHost=${proxy_host_http}
systemProp.http.proxyPort=${proxy_port_http}
systemProp.https.proxyHost=${proxy_host_https}
systemProp.https.proxyPort=${proxy_port_https}
EOL


source /etc/bash.bashrc














print_title "Done | android"
