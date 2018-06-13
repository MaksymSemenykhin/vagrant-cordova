#!/usr/bin/env bash
source /image/provision/output.sh
source /image/provision/functions.sh



print_title "Provision-script user: `whoami` | once-as-root"

print_title "Setting vars"

yml='/image/config/vagrant-local.yml';

timezone=$(grep_from_yml_string $yml timezone)
swap_file=$(grep_from_yml_string $yml swap)

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


print_info "timezone:$timezone"
fail_if_empty ${timezone}

print_info "swapfile:$swap_file"
fail_if_empty ${swap_file}


export DEBIAN_FRONTEND=noninteractive

print_title 'SETTING UP SWAP'
fallocate -l $(echo $swap_file)M /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

print_title "Configure timezone"
timedatectl set-timezone ${timezone} --no-ask-password

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
npm install cordova -g
# Install Node.js and npm
apt-get install -qqy nodejs

apt-get install git curl vim mc htop dstat zip jq -yqq
#apt-get install php-cli -yqq

apt-get install gradle -yqq







print_title "Done | once-as-root"
