#!/usr/bin/env bash
source /image/provision/output.sh

#== Import script args ==


#== Bash helpers ==

print_title "Provision-script user: `whoami` | once-as-root"

#== Provision script ==


export DEBIAN_FRONTEND=noninteractive


#print_title "Configure timezone"
#timedatectl set-timezone ${timezone} --no-ask-password

print_title "Update OS software"
apt-get update -yqq
apt-get upgrade -yqq


print_title "Install main software"
#apt install libavahi-compat-libdnssd-dev
# Install software to compile `C` code
# ilm server require g++ to compile some dependencies
apt-get install libavahi-compat-libdnssd-dev -yqq
apt-get install build-essential -yqq



print_title "Install additional software"

# Install Node.js 7.x repository
curl -sL https://deb.nodesource.com/setup_6.x | bash -

# Install Node.js and npm
apt-get install -qqy nodejs

apt-get install git curl vim mc htop dstat -yqq jq
apt-get install php-cli -yqq


apt-get install zip -yqq







print_title "Done | once-as-root"
